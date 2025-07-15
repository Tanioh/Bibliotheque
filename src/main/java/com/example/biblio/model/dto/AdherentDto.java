package com.example.biblio.model.dto;

import com.example.biblio.model.entity.Adherent;

public class AdherentDto {
    public Long id;
    public String nom;
    public String prenom;
    public Integer age;
    public String numero;
    public String email;
    public String statut;
    public Long profilId;
    public String profilNom;

    // Constructeur
    public AdherentDto(Long id, String nom, String prenom, Integer age, String numero, String email, String statut,
                       Long profilId, String profilNom) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.age = age;
        this.numero = numero;
        this.email = email;
        this.statut = statut;
        this.profilId = profilId;
        this.profilNom = profilNom;
    }

    // Méthode de mapping statique
    public static AdherentDto fromEntity(Adherent adherent) {
        return new AdherentDto(
            adherent.getIdAdherent(),
            adherent.getNom(),
            adherent.getPrenom(),
            adherent.getAge(),
            adherent.getNumero(),
            adherent.getEmail(),
            adherent.getStatut(),
            adherent.getProfil() != null ? adherent.getProfil().getIdProfil() : null,
            adherent.getProfil() != null ? adherent.getProfil().getNomProfil() : null
        );
    }
}