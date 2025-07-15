package com.example.biblio.repository;

import com.example.biblio.model.entity.Prolongement;
import com.example.biblio.model.entity.Pret;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProlongementRepository extends JpaRepository<Prolongement, Long> {
    void deleteByPret(Pret pret);
}