package com.example.biblio.model.dto;

import com.example.biblio.model.entity.Exemplaire;

public class ExemplaireDto {
    public Long id;
    public Long livreId;
    public String livreTitre;
    public String etat;
    public Boolean disponible;

    // Constructeur
    public ExemplaireDto(Long id, Long livreId, String livreTitre, String etat, Boolean disponible) {
        this.id = id;
        this.livreId = livreId;
        this.livreTitre = livreTitre;
        this.etat = etat;
        this.disponible = disponible;
    }

    // Méthode de mapping statique
    public static ExemplaireDto fromEntity(Exemplaire exemplaire) {
        return new ExemplaireDto(
                exemplaire.getIdExemplaire(),
                exemplaire.getLivre() != null ? exemplaire.getLivre().getIdLivre() : null,
                exemplaire.getLivre() != null ? exemplaire.getLivre().getTitre() : null,
                exemplaire.getEtat(),
                exemplaire.getDisponible());
    }
}