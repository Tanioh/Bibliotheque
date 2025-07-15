package com.example.biblio.model.dto;

import com.example.biblio.model.entity.Emplacement;

public class EmplacementDto {
    public Long id;
    public String typeEmplacement;

    // Constructeur
    public EmplacementDto(Long id, String typeEmplacement) {
        this.id = id;
        this.typeEmplacement = typeEmplacement;
    }

    // Méthode de mapping statique
    public static EmplacementDto fromEntity(Emplacement emplacement) {
        return new EmplacementDto(
            emplacement.getIdEmplacement(),
            emplacement.getTypeEmplacement()
        );
    }
}