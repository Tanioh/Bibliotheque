package com.example.biblio.model.dto;

import com.example.biblio.model.entity.Penalite;

import java.time.LocalDate;

public class PenaliteDto {
    public Long id;
    public Long adherentId;
    public String adherentNom;
    public String raison;
    public LocalDate datePenalite;
    public LocalDate dateFin;
    public Boolean levee;

    // Constructeur
    public PenaliteDto(Long id, Long adherentId, String adherentNom, String raison, LocalDate datePenalite,
            LocalDate dateFin, Boolean levee) {
        this.id = id;
        this.adherentId = adherentId;
        this.adherentNom = adherentNom;
        this.raison = raison;
        this.datePenalite = datePenalite;
        this.dateFin = dateFin;
        this.levee = levee;
    }

    // Méthode de mapping statique
    public static PenaliteDto fromEntity(Penalite penalite) {
        return new PenaliteDto(
                penalite.getIdPenalite(),
                penalite.getAdherent() != null ? penalite.getAdherent().getIdAdherent() : null,
                penalite.getAdherent() != null
                        ? penalite.getAdherent().getNom() + " " + penalite.getAdherent().getPrenom()
                        : null,
                penalite.getRaison(),
                penalite.getDatePenalite(),
                penalite.getDateFin(),
                penalite.getLevee());
    }
}