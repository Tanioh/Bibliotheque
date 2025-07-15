package com.example.biblio.model.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Statut")
public class Statut {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_statut")
    private Long idStatut;

    @Column(name = "libelle", unique = true, nullable = false)
    private String libelle;

    // Getters and Setters
    public Long getIdStatut() {
        return idStatut;
    }

    public void setIdStatut(Long idStatut) {
        this.idStatut = idStatut;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
}