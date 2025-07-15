package com.example.biblio.model.dto;

import com.example.biblio.model.entity.Profil;

public class ProfilDto {
    public Long id;
    public String nomProfil;
    public Integer quotaMaxPret;
    public Integer quotaMaxReservation;

    // Constructeur
    public ProfilDto(Long id, String nomProfil, Integer quotaMaxPret, Integer quotaMaxReservation) {
        this.id = id;
        this.nomProfil = nomProfil;
        this.quotaMaxPret = quotaMaxPret;
        this.quotaMaxReservation = quotaMaxReservation;
    }

    // Méthode de mapping statique
    public static ProfilDto fromEntity(Profil profil) {
        return new ProfilDto(
                profil.getIdProfil(),
                profil.getNomProfil(),
                profil.getQuotaMaxPret(),
                profil.getQuotaMaxReservation());
    }
}