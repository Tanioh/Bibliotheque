package com.example.biblio.repository;

import com.example.biblio.model.entity.Statut;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;


public interface StatutRepository extends JpaRepository<Statut, Long> {
    Optional<Statut> findByLibelle(String libelle);
}