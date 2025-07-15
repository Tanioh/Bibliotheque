package com.example.biblio.model.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Profil")
public class Profil {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_profil")
    private Long idProfil;

    @Column(name = "nom_profil", unique = true, nullable = false)
    private String nomProfil;

    @Column(name = "quota_max_pret", nullable = false)
    private Integer quotaMaxPret;

    @Column(name = "quota_max_reservation", nullable = false)
    private Integer quotaMaxReservation;

    // Getters and Setters
    public Long getIdProfil() {
        return idProfil;
    }

    public void setIdProfil(Long idProfil) {
        this.idProfil = idProfil;
    }

    public String getNomProfil() {
        return nomProfil;
    }

    public void setNomProfil(String nomProfil) {
        this.nomProfil = nomProfil;
    }

    public Integer getQuotaMaxPret() {
        return quotaMaxPret;
    }

    public void setQuotaMaxPret(Integer quotaMaxPret) {
        this.quotaMaxPret = quotaMaxPret;
    }

    public Integer getQuotaMaxReservation() {
        return quotaMaxReservation;
    }

    public void setQuotaMaxReservation(Integer quotaMaxReservation) {
        this.quotaMaxReservation = quotaMaxReservation;
    }
}