package com.example.biblio.model.dto;

import com.example.biblio.model.entity.Pret;

import java.time.LocalDate;

public class PretDto {
    public Long id;
    public Long adherentId;
    public String adherentNom;
    public Long exemplaireId;
    public String exemplaireTitre;
    public LocalDate datePret;
    public LocalDate dateRetourPrevue;

    public Long statutId;
    public String statutLibelle;

    // Constructeur
    public PretDto(Long id, Long adherentId, String adherentNom, Long exemplaireId, String exemplaireTitre,
            LocalDate datePret, LocalDate dateRetourPrevue,
            Long statutId, String statutLibelle) {
        this.id = id;
        this.adherentId = adherentId;
        this.adherentNom = adherentNom;
        this.exemplaireId = exemplaireId;
        this.exemplaireTitre = exemplaireTitre;
        this.datePret = datePret;
        this.dateRetourPrevue = dateRetourPrevue;
        this.statutId = statutId;
        this.statutLibelle = statutLibelle;
    }

    // Méthode de mapping statique
    public static PretDto fromEntity(Pret pret) {
        return new PretDto(
                pret.getIdPret(),
                pret.getAdherent() != null ? pret.getAdherent().getIdAdherent() : null,
                pret.getAdherent() != null ? pret.getAdherent().getNom() + " " + pret.getAdherent().getPrenom() : null,
                pret.getExemplaire() != null ? pret.getExemplaire().getIdExemplaire() : null,
                pret.getExemplaire() != null && pret.getExemplaire().getLivre() != null
                        ? pret.getExemplaire().getLivre().getTitre()
                        : null,
                pret.getDatePret(),
                pret.getDateRetourPrevue(),
                pret.getStatut() != null ? pret.getStatut().getIdStatut() : null,
                pret.getStatut() != null ? pret.getStatut().getLibelle() : null);
    }
}