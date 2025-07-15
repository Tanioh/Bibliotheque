package com.example.biblio.repository;

import com.example.biblio.entity.Abonnement;
import com.example.biblio.model.entity.Adherent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AbonnementRepository extends JpaRepository<Abonnement, Long> {
    
    // Trouver l'abonnement actif d'un adhérent
    @Query("SELECT a FROM Abonnement a WHERE a.adherent = :adherent " +
           "AND a.statut = 'actif' AND a.dateDebut <= :today AND a.dateFin >= :today")
    Optional<Abonnement> findAbonnementActifByAdherent(@Param("adherent") Adherent adherent, 
                                                       @Param("today") LocalDate today);
    
    // Vérifier si un adhérent a un abonnement actif
    @Query("SELECT COUNT(a) > 0 FROM Abonnement a WHERE a.adherent = :adherent " +
           "AND a.statut = 'actif' AND a.dateDebut <= :today AND a.dateFin >= :today")
    boolean hasAbonnementActif(@Param("adherent") Adherent adherent, 
                              @Param("today") LocalDate today);
    
    // Trouver tous les abonnements d'un adhérent
    List<Abonnement> findByAdherentOrderByDateCreationDesc(Adherent adherent);
    
    // Trouver les abonnements par statut
    List<Abonnement> findByStatutOrderByDateCreationDesc(String statut);
    
    // Trouver les abonnements qui expirent bientôt
    @Query("SELECT a FROM Abonnement a WHERE a.statut = 'actif' " +
           "AND a.dateFin BETWEEN :today AND :dateLimite")
    List<Abonnement> findAbonnementsExpirantBientot(@Param("today") LocalDate today,
                                                    @Param("dateLimite") LocalDate dateLimite);
    
    // Trouver les abonnements expirés
    @Query("SELECT a FROM Abonnement a WHERE a.statut = 'actif' AND a.dateFin < :today")
    List<Abonnement> findAbonnementsExpires(@Param("today") LocalDate today);
    
    // Trouver les abonnements par type
    List<Abonnement> findByTypeAbonnementOrderByDateCreationDesc(String typeAbonnement);
}