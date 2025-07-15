package com.example.biblio.model.dto;

import com.example.biblio.model.entity.Livre;

public class LivreDto {
    public Long id;
    public String titre;
    public String genre;
    public String auteur;
    public Integer annee;
    public Integer ageMinimum;

    // Constructeur
    public LivreDto(Long id, String titre, String genre, String auteur, Integer annee, Integer ageMinimum) {
        this.id = id;
        this.titre = titre;
        this.genre = genre;
        this.auteur = auteur;
        this.annee = annee;
        this.ageMinimum = ageMinimum;
    }

    // Méthode de mapping statique
    public static LivreDto fromEntity(Livre livre) {
        return new LivreDto(
                livre.getIdLivre(),
                livre.getTitre(),
                livre.getGenre(),
                livre.getAuteur(),
                livre.getAnnee(),
                livre.getAgeMinimum());
    }
}