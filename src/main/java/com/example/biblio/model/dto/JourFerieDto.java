package com.example.biblio.model.dto;

import com.example.biblio.model.entity.JourFerie;

import java.time.LocalDate;

public class JourFerieDto {
    public Long id;
    public LocalDate dateFerie;
    public String description;

    // Constructeur
    public JourFerieDto(Long id, LocalDate dateFerie, String description) {
        this.id = id;
        this.dateFerie = dateFerie;
        this.description = description;
    }

    // Méthode de mapping statique
    public static JourFerieDto fromEntity(JourFerie jourFerie) {
        return new JourFerieDto(
                jourFerie.getIdJour(),
                jourFerie.getDateFerie(),
                jourFerie.getDescription());
    }
}