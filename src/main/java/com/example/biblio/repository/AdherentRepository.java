package com.example.biblio.repository;

import com.example.biblio.model.entity.Adherent;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdherentRepository extends JpaRepository<Adherent, Long> {
}
