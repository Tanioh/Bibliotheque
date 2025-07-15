package com.example.biblio.model.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Emplacement")
public class Emplacement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_emplacement")
    private Long idEmplacement;

    @Column(name = "type_emplacement", nullable = false, unique = true)
    private String typeEmplacement;

    // Getters et setters
    public Long getIdEmplacement() {
        return idEmplacement;
    }

    public void setIdEmplacement(Long idEmplacement) {
        this.idEmplacement = idEmplacement;
    }

    public String getTypeEmplacement() {
        return typeEmplacement;
    }

    public void setTypeEmplacement(String typeEmplacement) {
        this.typeEmplacement = typeEmplacement;
    }
}