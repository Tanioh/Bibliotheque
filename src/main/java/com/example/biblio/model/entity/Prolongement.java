package com.example.biblio.model.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "Prolongement")
public class Prolongement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_prolongement")
    private Long idProlongement;

    @ManyToOne
    @JoinColumn(name = "id_pret")
    private Pret pret;

    @Column(name = "date_prolongement", nullable = false)
    private LocalDate dateProlongement;

    @Column(name = "nouvelle_date_retour", nullable = false)
    private LocalDate nouvelleDateRetour;

    @ManyToOne
    @JoinColumn(name = "id_statut")
    private Statut statut;

    // Getters and Setters
    public Long getIdProlongement() {
        return idProlongement;
    }

    public void setIdProlongement(Long idProlongement) {
        this.idProlongement = idProlongement;
    }

    public Pret getPret() {
        return pret;
    }

    public void setPret(Pret pret) {
        this.pret = pret;
    }

    public LocalDate getDateProlongement() {
        return dateProlongement;
    }

    public void setDateProlongement(LocalDate dateProlongement) {
        this.dateProlongement = dateProlongement;
    }

    public LocalDate getNouvelleDateRetour() {
        return nouvelleDateRetour;
    }

    public void setNouvelleDateRetour(LocalDate nouvelleDateRetour) {
        this.nouvelleDateRetour = nouvelleDateRetour;
    }

    public Statut getStatut() {
        return statut;
    }

    public void setStatut(Statut statut) {
        this.statut = statut;
    }
}