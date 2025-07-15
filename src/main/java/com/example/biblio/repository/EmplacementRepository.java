package com.example.biblio.repository;

import com.example.biblio.model.entity.Emplacement;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmplacementRepository extends JpaRepository<Emplacement, Long> {
}