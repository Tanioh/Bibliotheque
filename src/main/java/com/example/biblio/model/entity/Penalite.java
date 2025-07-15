package com.example.biblio.model.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "Penalite")
public class Penalite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_penalite")
    private Long idPenalite;

    @ManyToOne
    @JoinColumn(name = "id_adherent")
    private Adherent adherent;

    @Column(name = "raison", nullable = false)
    private String raison;

    @Column(name = "date_penalite", nullable = false)
    private LocalDate datePenalite;

    @Column(name = "date_fin")
    private LocalDate dateFin;

    @Column(name = "levee", nullable = false)
    private Boolean levee = false;

    // Getters and Setters
    public Long getIdPenalite() {
        return idPenalite;
    }

    public void setIdPenalite(Long idPenalite) {
        this.idPenalite = idPenalite;
    }

    public Adherent getAdherent() {
        return adherent;
    }

    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }

    public String getRaison() {
        return raison;
    }

    public void setRaison(String raison) {
        this.raison = raison;
    }

    public LocalDate getDatePenalite() {
        return datePenalite;
    }

    public void setDatePenalite(LocalDate datePenalite) {
        this.datePenalite = datePenalite;
    }

    public LocalDate getDateFin() {
        return dateFin;
    }

    public void setDateFin(LocalDate dateFin) {
        this.dateFin = dateFin;
    }

    public Boolean getLevee() {
        return levee;
    }

    public void setLevee(Boolean levee) {
        this.levee = levee;
    }
}