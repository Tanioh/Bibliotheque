package com.example.biblio.model.dto;
import com.example.biblio.model.entity.Admin;

public class AdminDto {
    public Long id;
    public String nomUtilisateur;
    public String motDePasse;

    // Constructeur
    public AdminDto(Long id, String nomUtilisateur, String motDePasse) {
        this.id = id;
        this.nomUtilisateur = nomUtilisateur;
        this.motDePasse = motDePasse;
    }

    // Méthode de mapping statique
    public static AdminDto fromEntity(Admin admin) {
        return new AdminDto(
            admin.getIdAdmin(),
            admin.getNomUtilisateur(),
            admin.getMotDePasse()
        );
    }
}