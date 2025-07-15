package com.example.biblio.model.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "Jour_Ferie")
public class JourFerie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_jour")
    private Long idJour;

    @Column(name = "date_ferie", unique = true, nullable = false)
    private LocalDate dateFerie;

    @Column(name = "description")
    private String description;

    // Getters and Setters
    public Long getIdJour() {
        return idJour;
    }

    public void setIdJour(Long idJour) {
        this.idJour = idJour;
    }

    public LocalDate getDateFerie() {
        return dateFerie;
    }

    public void setDateFerie(LocalDate dateFerie) {
        this.dateFerie = dateFerie;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}