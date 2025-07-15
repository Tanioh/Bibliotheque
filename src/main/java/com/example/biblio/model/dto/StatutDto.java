package com.example.biblio.model.dto;

import com.example.biblio.model.entity.Statut;

public class StatutDto {
    public Long id;
    public String libelle;

    // Constructeur
    public StatutDto(Long id, String libelle) {
        this.id = id;
        this.libelle = libelle;
    }

    // Méthode de mapping statique
    public static StatutDto fromEntity(Statut statut) {
        return new StatutDto(
                statut.getIdStatut(),
                statut.getLibelle());
    }
}