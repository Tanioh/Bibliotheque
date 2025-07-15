package com.example.biblio.entity;

import com.example.biblio.model.entity.Adherent;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "Abonnement")
public class Abonnement {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_abonnement")
    private Long idAbonnement;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_adherent", nullable = false)
    private Adherent adherent;
    
    @Column(name = "type_abonnement", nullable = false, length = 50)
    private String typeAbonnement;
    
    @Column(name = "date_debut", nullable = false)
    private LocalDate dateDebut;
    
    @Column(name = "date_fin", nullable = false)
    private LocalDate dateFin;
    
    @Column(name = "prix", nullable = false, precision = 10, scale = 2)
    private BigDecimal prix;
    
    @Column(name = "statut", length = 20)
    private String statut = "actif";
    
    @Column(name = "auto_renouvellement")
    private Boolean autoRenouvellement = false;
    
    @Column(name = "date_creation")
    private LocalDateTime dateCreation;
    
    // Constructeurs
    public Abonnement() {
        this.dateCreation = LocalDateTime.now();
    }
    
    public Abonnement(Adherent adherent, String typeAbonnement, LocalDate dateDebut, 
                     LocalDate dateFin, BigDecimal prix) {
        this();
        this.adherent = adherent;
        this.typeAbonnement = typeAbonnement;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.prix = prix;
    }
    
    // Méthode utilitaire pour vérifier si l'abonnement est actif
    public boolean isActif() {
        return "actif".equals(statut) && 
               LocalDate.now().isBefore(dateFin.plusDays(1)) && 
               LocalDate.now().isAfter(dateDebut.minusDays(1));
    }
    
    // Getters et Setters
    public Long getIdAbonnement() {
        return idAbonnement;
    }
    
    public void setIdAbonnement(Long idAbonnement) {
        this.idAbonnement = idAbonnement;
    }
    
    public Adherent getAdherent() {
        return adherent;
    }
    
    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }
    
    public String getTypeAbonnement() {
        return typeAbonnement;
    }
    
    public void setTypeAbonnement(String typeAbonnement) {
        this.typeAbonnement = typeAbonnement;
    }
    
    public LocalDate getDateDebut() {
        return dateDebut;
    }
    
    public void setDateDebut(LocalDate dateDebut) {
        this.dateDebut = dateDebut;
    }
    
    public LocalDate getDateFin() {
        return dateFin;
    }
    
    public void setDateFin(LocalDate dateFin) {
        this.dateFin = dateFin;
    }
    
    public BigDecimal getPrix() {
        return prix;
    }
    
    public void setPrix(BigDecimal prix) {
        this.prix = prix;
    }
    
    public String getStatut() {
        return statut;
    }
    
    public void setStatut(String statut) {
        this.statut = statut;
    }
    
    public Boolean getAutoRenouvellement() {
        return autoRenouvellement;
    }
    
    public void setAutoRenouvellement(Boolean autoRenouvellement) {
        this.autoRenouvellement = autoRenouvellement;
    }
    
    public LocalDateTime getDateCreation() {
        return dateCreation;
    }
    
    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }
}