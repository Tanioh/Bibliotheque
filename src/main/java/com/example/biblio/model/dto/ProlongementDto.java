package com.example.biblio.model.dto;

import com.example.biblio.model.entity.Prolongement;

import java.time.LocalDate;

public class ProlongementDto {
    public Long id;
    public Long pretId;
    public String pretDetails;
    public LocalDate dateProlongement;
    public LocalDate nouvelleDateRetour;
    public Long statutId;
    public String statutLibelle;

    // Constructeur
    public ProlongementDto(Long id, Long pretId, String pretDetails, LocalDate dateProlongement,
            LocalDate nouvelleDateRetour, Long statutId, String statutLibelle) {
        this.id = id;
        this.pretId = pretId;
        this.pretDetails = pretDetails;
        this.dateProlongement = dateProlongement;
        this.nouvelleDateRetour = nouvelleDateRetour;
        this.statutId = statutId;
        this.statutLibelle = statutLibelle;
    }

    // Méthode de mapping statique
    public static ProlongementDto fromEntity(Prolongement prolongement) {
        return new ProlongementDto(
                prolongement.getIdProlongement(),
                prolongement.getPret() != null ? prolongement.getPret().getIdPret() : null,
                prolongement.getPret() != null && prolongement.getPret().getExemplaire() != null
                        && prolongement.getPret().getExemplaire().getLivre() != null
                                ? prolongement.getPret().getExemplaire().getLivre().getTitre()
                                : null,
                prolongement.getDateProlongement(),
                prolongement.getNouvelleDateRetour(),
                prolongement.getStatut() != null ? prolongement.getStatut().getIdStatut() : null,
                prolongement.getStatut() != null ? prolongement.getStatut().getLibelle() : null);
    }
}