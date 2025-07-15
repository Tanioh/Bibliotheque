package com.example.biblio.dto;

import com.example.biblio.entity.Abonnement;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class AbonnementDto {
    
    private Long idAbonnement;
    private Long idAdherent;
    private String nomAdherent;
    private String prenomAdherent;
    private String typeAbonnement;
    private LocalDate dateDebut;
    private LocalDate dateFin;
    private BigDecimal prix;
    private String statut;
    private Boolean autoRenouvellement;
    private LocalDateTime dateCreation;
    private boolean actif;
    
    // Constructeurs
    public AbonnementDto() {}
    
    public AbonnementDto(Long idAbonnement, Long idAdherent, String nomAdherent, 
                        String prenomAdherent, String typeAbonnement, LocalDate dateDebut, 
                        LocalDate dateFin, BigDecimal prix, String statut, 
                        Boolean autoRenouvellement, LocalDateTime dateCreation) {
        this.idAbonnement = idAbonnement;
        this.idAdherent = idAdherent;
        this.nomAdherent = nomAdherent;
        this.prenomAdherent = prenomAdherent;
        this.typeAbonnement = typeAbonnement;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.prix = prix;
        this.statut = statut;
        this.autoRenouvellement = autoRenouvellement;
        this.dateCreation = dateCreation;
        this.actif = "actif".equals(statut) && 
                    LocalDate.now().isBefore(dateFin.plusDays(1)) && 
                    LocalDate.now().isAfter(dateDebut.minusDays(1));
    }
    
    // Méthode statique pour créer un DTO à partir d'une entité
    public static AbonnementDto fromEntity(Abonnement abonnement) {
        if (abonnement == null) {
            return null;
        }
        
        return new AbonnementDto(
            abonnement.getIdAbonnement(),
            abonnement.getAdherent() != null ? abonnement.getAdherent().getIdAdherent() : null,
            abonnement.getAdherent() != null ? abonnement.getAdherent().getNom() : null,
            abonnement.getAdherent() != null ? abonnement.getAdherent().getPrenom() : null,
            abonnement.getTypeAbonnement(),
            abonnement.getDateDebut(),
            abonnement.getDateFin(),
            abonnement.getPrix(),
            abonnement.getStatut(),
            abonnement.getAutoRenouvellement(),
            abonnement.getDateCreation()
        );
    }
    
    // Getters et Setters
    public Long getIdAbonnement() {
        return idAbonnement;
    }
    
    public void setIdAbonnement(Long idAbonnement) {
        this.idAbonnement = idAbonnement;
    }
    
    public Long getIdAdherent() {
        return idAdherent;
    }
    
    public void setIdAdherent(Long idAdherent) {
        this.idAdherent = idAdherent;
    }
    
    public String getNomAdherent() {
        return nomAdherent;
    }
    
    public void setNomAdherent(String nomAdherent) {
        this.nomAdherent = nomAdherent;
    }
    
    public String getPrenomAdherent() {
        return prenomAdherent;
    }
    
    public void setPrenomAdherent(String prenomAdherent) {
        this.prenomAdherent = prenomAdherent;
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
    
    public boolean isActif() {
        return actif;
    }
    
    public void setActif(boolean actif) {
        this.actif = actif;
    }
    
    public String getNomCompletAdherent() {
        return (prenomAdherent != null ? prenomAdherent : "") + " " + (nomAdherent != null ? nomAdherent : "");
    }
}