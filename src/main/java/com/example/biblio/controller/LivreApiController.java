package com.example.biblio.controller;

import com.example.biblio.model.entity.Livre;
import com.example.biblio.model.entity.Exemplaire;
import com.example.biblio.repository.LivreRepository;
import com.example.biblio.repository.ExemplaireRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/livres")
public class LivreApiController {
    
    @Autowired
    private LivreRepository livreRepository;
    
    @Autowired
    private ExemplaireRepository exemplaireRepository;
    
    @GetMapping("/{idLivre}")
    public ResponseEntity<Map<String, Object>> getLivreAvecExemplaires(@PathVariable Long idLivre) {
        // Vérifier si le livre existe
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) {
            return ResponseEntity.notFound().build();
        }
        
        // Récupérer tous les exemplaires de ce livre
        List<Exemplaire> exemplaires = exemplaireRepository.findAll().stream()
            .filter(ex -> ex.getLivre().getIdLivre().equals(idLivre))
            .collect(Collectors.toList());
        
        // Créer la réponse JSON
        Map<String, Object> response = new HashMap<>();
        
        // Informations du livre
        Map<String, Object> livreInfo = new HashMap<>();
        livreInfo.put("idLivre", livre.getIdLivre());
        livreInfo.put("titre", livre.getTitre());
        livreInfo.put("auteur", livre.getAuteur());
        livreInfo.put("genre", livre.getGenre());
        livreInfo.put("annee", livre.getAnnee());
        livreInfo.put("ageMinimum", livre.getAgeMinimum());
        
        // Liste des exemplaires avec leur disponibilité
        List<Map<String, Object>> exemplairesInfo = exemplaires.stream()
            .map(ex -> {
                Map<String, Object> exInfo = new HashMap<>();
                exInfo.put("idExemplaire", ex.getIdExemplaire());
                exInfo.put("etat", ex.getEtat());
                exInfo.put("disponible", ex.getDisponible());
                return exInfo;
            })
            .collect(Collectors.toList());
        
        // Statistiques de disponibilité
        long totalExemplaires = exemplaires.size();
        long exemplairesDisponibles = exemplaires.stream()
            .mapToLong(ex -> ex.getDisponible() ? 1 : 0)
            .sum();
        
        response.put("livre", livreInfo);
        response.put("exemplaires", exemplairesInfo);
        response.put("totalExemplaires", totalExemplaires);
        response.put("exemplairesDisponibles", exemplairesDisponibles);
        response.put("exemplairesEmpruntes", totalExemplaires - exemplairesDisponibles);
        
        return ResponseEntity.ok(response);
    }
}