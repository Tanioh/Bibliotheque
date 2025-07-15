package com.example.biblio.service;

import com.example.biblio.model.entity.Adherent;
import com.example.biblio.model.entity.Exemplaire;
import com.example.biblio.model.entity.Penalite;
import com.example.biblio.model.entity.Emplacement;
import com.example.biblio.model.entity.Pret;
import com.example.biblio.model.entity.Statut;
import com.example.biblio.repository.PretRepository;
import com.example.biblio.repository.ExemplaireRepository;
import com.example.biblio.repository.PenaliteRepository;
import com.example.biblio.repository.ProlongementRepository;
import com.example.biblio.service.AbonnementService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@Service
public class PretService {
    @Autowired
    private PretRepository pretRepository;
    @Autowired
    private ExemplaireRepository exemplaireRepository;
    @Autowired
    private PenaliteRepository penaliteRepository;
    @Autowired
    private ProlongementRepository prolongementRepository;
    @Autowired
    private AbonnementService abonnementService;

    public Pret fairePret(Adherent adherent, Exemplaire exemplaire, LocalDate datePret, LocalDate dateRetourPrevue, Emplacement emplacement, Statut statut) {
    // Vérifier si l'adhérent a un abonnement actif
    if (!abonnementService.hasAbonnementActif(adherent)) {
        throw new IllegalStateException("Cet adhérent n'a pas d'abonnement actif et ne peut pas emprunter.");
    }
    
    boolean penalise = penaliteRepository.existsByAdherentAndLeveeFalseAndDateFinAfter(adherent, LocalDate.now());
    if (penalise) {
        throw new IllegalStateException("Cet adhérent est pénalisé et ne peut pas emprunter pour le moment.");
    }
        // Vérifier le quota
    long nbPretsEnCours = pretRepository.countByAdherentAndStatut_Libelle(adherent, "en_cours");
    int quotaMax = adherent.getProfil() != null ? adherent.getProfil().getQuotaMaxPret() : 0;
    
    // Vérifier si le quota maximum est atteint AVANT d'ajouter ce nouveau prêt
    if (nbPretsEnCours >= quotaMax) {
        String profilNom = adherent.getProfil() != null ? adherent.getProfil().getNomProfil() : "Aucun";
        if (quotaMax == 0) {
            throw new IllegalStateException("Cet adhérent a le profil '" + profilNom + "' qui ne permet aucun prêt. Veuillez modifier son profil.");
        } else {
            throw new IllegalStateException("Quota de prêts atteint pour cet adhérent (" + nbPretsEnCours + "/" + quotaMax + " - Profil: " + profilNom + "). Impossible d'emprunter un livre supplémentaire.");
        }
    }

    Pret pret = new Pret();
    pret.setAdherent(adherent);
    pret.setExemplaire(exemplaire);
    pret.setDatePret(datePret);
    pret.setDateRetourPrevue(dateRetourPrevue);
    pret.setEmplacement(emplacement);
    pret.setStatut(statut);

    exemplaire.setDisponible(false);
    exemplaireRepository.save(exemplaire);

    return pretRepository.save(pret);
}

      @Transactional
      public String rendrePret(Pret pret, LocalDate dateRendu) {
        Exemplaire exemplaire = pret.getExemplaire();
        Adherent adherent = pret.getAdherent();

        long retard = ChronoUnit.DAYS.between(pret.getDateRetourPrevue(), dateRendu);
        String message;

        if (retard > 0) {
            Penalite penalite = new Penalite();
            penalite.setAdherent(adherent);
            penalite.setRaison("Retard de retour");
            penalite.setDatePenalite(dateRendu);
            penalite.setDateFin(dateRendu.plusDays(retard));
            penalite.setLevee(false);
            penaliteRepository.save(penalite);
            message = "Livre rendu avec " + retard + " jour(s) de retard. Vous êtes pénalisé pour " + retard + " jour(s).";
        } else {
            message = "Livre rendu à temps. Merci !";
        }

        // Supprimer d'abord tous les prolongements associés à ce prêt
        prolongementRepository.deleteByPret(pret);
        
        // Supprimer le prêt et rendre l'exemplaire disponible
        pretRepository.delete(pret);
        exemplaire.setDisponible(true);
        exemplaireRepository.save(exemplaire);

        return message;
    }
}
