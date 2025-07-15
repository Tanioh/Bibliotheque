package com.example.biblio.repository;

import com.example.biblio.model.entity.Reservation;
import com.example.biblio.model.entity.Adherent;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    void deleteByAdherent(Adherent adherent);
}