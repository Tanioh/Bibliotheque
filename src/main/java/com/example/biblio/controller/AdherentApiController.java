package com.example.biblio.controller;

import com.example.biblio.model.entity.Adherent;
import com.example.biblio.model.entity.Penalite;
import com.example.biblio.repository.AdherentRepository;
import com.example.biblio.repository.PretRepository;
import com.example.biblio.repository.PenaliteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;

@RestController
@RequestMapping("/api/adherents")
public class AdherentApiController {
    
    @Autowired
    private AdherentRepository adherentRepository;
    
    @Autowired
    private PretRepository pretRepository;
    
    @Autowired
    private PenaliteRepository penaliteRepository;
    
    @GetMapping("/{idAdherent}")
    public ResponseEntity<Map<String, Object>> getAdherentInfo(@PathVariable Long idAdherent) {
        // Vérifier si l'adhérent existe
        Optional<Adherent> adherentOpt = adherentRepository.findById(idAdherent);
        if (adherentOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        
        Adherent adherent = adherentOpt.get();
        
        // Créer la réponse JSON
        Map<String, Object> response = new HashMap<>();
        
        // Informations de base de l'adhérent
        Map<String, Object> adherentInfo = new HashMap<>();
        adherentInfo.put("idAdherent", adherent.getIdAdherent());
        adherentInfo.put("nom", adherent.getNom());
        adherentInfo.put("prenom", adherent.getPrenom());
        adherentInfo.put("email", adherent.getEmail());
        adherentInfo.put("age", adherent.getAge());
        adherentInfo.put("numero", adherent.getNumero());
        adherentInfo.put("statut", adherent.getStatut());
        
        // Informations du profil
        Map<String, Object> profilInfo = new HashMap<>();
        if (adherent.getProfil() != null) {
            profilInfo.put("nomProfil", adherent.getProfil().getNomProfil());
            profilInfo.put("quotaMaxPret", adherent.getProfil().getQuotaMaxPret());
            profilInfo.put("quotaMaxReservation", adherent.getProfil().getQuotaMaxReservation());
        } else {
            profilInfo.put("nomProfil", "Aucun profil");
            profilInfo.put("quotaMaxPret", 0);
            profilInfo.put("quotaMaxReservation", 0);
        }
        
        // Calcul du quota
        long nbPretsEnCours = pretRepository.countByAdherentAndStatut_Libelle(adherent, "en_cours");
        int quotaMax = adherent.getProfil() != null ? adherent.getProfil().getQuotaMaxPret() : 0;
        int quotaRestant = Math.max(0, quotaMax - (int) nbPretsEnCours);
        
        Map<String, Object> quotaInfo = new HashMap<>();
        quotaInfo.put("nbPretsEnCours", nbPretsEnCours);
        quotaInfo.put("quotaMax", quotaMax);
        quotaInfo.put("quotaRestant", quotaRestant);
        
        // Vérification des pénalités
        LocalDate aujourdhui = LocalDate.now();
        boolean estPenalise = penaliteRepository.existsByAdherentAndLeveeFalseAndDateFinAfter(adherent, aujourdhui);
        
        Map<String, Object> penaliteInfo = new HashMap<>();
        penaliteInfo.put("estPenalise", estPenalise);
        
        if (estPenalise) {
            Optional<Penalite> penaliteActiveOpt = penaliteRepository.findByAdherentAndLeveeFalse(adherent);
            if (penaliteActiveOpt.isPresent()) {
                Penalite penaliteActive = penaliteActiveOpt.get();
                long joursRestants = ChronoUnit.DAYS.between(aujourdhui, penaliteActive.getDateFin());
                
                penaliteInfo.put("raison", penaliteActive.getRaison());
                penaliteInfo.put("datePenalite", penaliteActive.getDatePenalite());
                penaliteInfo.put("dateFin", penaliteActive.getDateFin());
                penaliteInfo.put("joursRestants", Math.max(0, joursRestants));
                penaliteInfo.put("levee", penaliteActive.getLevee());
            }
        }
        
        // Assembler la réponse finale
        response.put("adherent", adherentInfo);
        response.put("profil", profilInfo);
        response.put("quota", quotaInfo);
        response.put("penalite", penaliteInfo);
        
        return ResponseEntity.ok(response);
    }
}