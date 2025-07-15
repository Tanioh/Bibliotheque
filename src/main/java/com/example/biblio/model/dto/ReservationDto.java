package com.example.biblio.model.dto;

import com.example.biblio.model.entity.Reservation;

import java.time.LocalDate;

public class ReservationDto {
        public Long id;
        public Long adherentId;
        public String adherentNom;
        public Long exemplaireId;
        public String exemplaireTitre;
        public LocalDate dateReservation;
        public Long statutId;
        public String statutLibelle;

        // Constructeur
        public ReservationDto(Long id, Long adherentId, String adherentNom, Long exemplaireId, String exemplaireTitre,
                        LocalDate dateReservation, Long statutId, String statutLibelle) {
                this.id = id;
                this.adherentId = adherentId;
                this.adherentNom = adherentNom;
                this.exemplaireId = exemplaireId;
                this.exemplaireTitre = exemplaireTitre;
                this.dateReservation = dateReservation;
                this.statutId = statutId;
                this.statutLibelle = statutLibelle;
        }

        // Méthode de mapping statique
        public static ReservationDto fromEntity(Reservation reservation) {
                return new ReservationDto(
                                reservation.getIdReservation(),
                                reservation.getAdherent() != null ? reservation.getAdherent().getIdAdherent() : null,
                                reservation.getAdherent() != null
                                                ? reservation.getAdherent().getNom() + " "
                                                                + reservation.getAdherent().getPrenom()
                                                : null,
                                reservation.getExemplaire() != null ? reservation.getExemplaire().getIdExemplaire()
                                                : null,
                                reservation.getExemplaire() != null && reservation.getExemplaire().getLivre() != null
                                                ? reservation.getExemplaire().getLivre().getTitre()
                                                : null,
                                reservation.getDateReservation(),
                                reservation.getStatut() != null ? reservation.getStatut().getIdStatut() : null,
                                reservation.getStatut() != null ? reservation.getStatut().getLibelle() : null);
        }
}