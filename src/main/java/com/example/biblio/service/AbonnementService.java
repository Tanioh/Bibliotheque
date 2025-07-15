package com.example.biblio.service;

import com.example.biblio.entity.Abonnement;
import com.example.biblio.model.entity.Adherent;
import com.example.biblio.repository.AbonnementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class AbonnementService {
    
    @Autowired
    private AbonnementRepository abonnementRepository;
    
    // Créer un nouvel abonnement
    public Abonnement creerAbonnement(Adherent adherent, String typeAbonnement, 
                                     LocalDate dateDebut, LocalDate dateFin, BigDecimal prix) {
        // Vérifier s'il y a déjà un abonnement actif
        if (hasAbonnementActif(adherent)) {
            throw new RuntimeException("L'adhérent a déjà un abonnement actif");
        }
        
        Abonnement abonnement = new Abonnement(adherent, typeAbonnement, dateDebut, dateFin, prix);
        return abonnementRepository.save(abonnement);
    }
    
    // Vérifier si un adhérent a un abonnement actif
    public boolean hasAbonnementActif(Adherent adherent) {
        return abonnementRepository.hasAbonnementActif(adherent, LocalDate.now());
    }
    
    // Obtenir l'abonnement actif d'un adhérent
    public Optional<Abonnement> getAbonnementActif(Adherent adherent) {
        return abonnementRepository.findAbonnementActifByAdherent(adherent, LocalDate.now());
    }
    
    // Renouveler un abonnement
    public Abonnement renouvellerAbonnement(Long idAbonnement, LocalDate nouvelleDateFin) {
        Abonnement abonnement = abonnementRepository.findById(idAbonnement)
            .orElseThrow(() -> new RuntimeException("Abonnement non trouvé"));
        
        abonnement.setDateFin(nouvelleDateFin);
        return abonnementRepository.save(abonnement);
    }
    
    // Résilier un abonnement
    public void resilierAbonnement(Long idAbonnement) {
        Abonnement abonnement = abonnementRepository.findById(idAbonnement)
            .orElseThrow(() -> new RuntimeException("Abonnement non trouvé"));
        
        abonnement.setStatut("resilie");
        abonnementRepository.save(abonnement);
    }
    
    // Obtenir tous les abonnements d'un adhérent
    public List<Abonnement> getAbonnementsByAdherent(Adherent adherent) {
        return abonnementRepository.findByAdherentOrderByDateCreationDesc(adherent);
    }
    
    // Obtenir tous les abonnements
    public List<Abonnement> getAllAbonnements() {
        return abonnementRepository.findAll();
    }
    
    // Obtenir les abonnements par statut
    public List<Abonnement> getAbonnementsByStatut(String statut) {
        return abonnementRepository.findByStatutOrderByDateCreationDesc(statut);
    }
    
    // Obtenir les abonnements qui expirent dans les 7 prochains jours
    public List<Abonnement> getAbonnementsExpirantBientot() {
        LocalDate today = LocalDate.now();
        LocalDate dateLimite = today.plusDays(7);
        return abonnementRepository.findAbonnementsExpirantBientot(today, dateLimite);
    }
    
    // Mettre à jour les abonnements expirés
    public void mettreAJourAbonnementsExpires() {
        List<Abonnement> abonnementsExpires = abonnementRepository.findAbonnementsExpires(LocalDate.now());
        for (Abonnement abonnement : abonnementsExpires) {
            abonnement.setStatut("expire");
            abonnementRepository.save(abonnement);
        }
    }
    
    // Obtenir un abonnement par ID
    public Optional<Abonnement> getAbonnementById(Long id) {
        return abonnementRepository.findById(id);
    }
    
    // Sauvegarder un abonnement
    public Abonnement saveAbonnement(Abonnement abonnement) {
        return abonnementRepository.save(abonnement);
    }
    
    // Supprimer un abonnement
    public void deleteAbonnement(Long id) {
        abonnementRepository.deleteById(id);
    }
}