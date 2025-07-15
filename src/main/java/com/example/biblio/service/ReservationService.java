package com.example.biblio.service;

import com.example.biblio.model.entity.Adherent;
import com.example.biblio.model.entity.Exemplaire;
import com.example.biblio.model.entity.Reservation;
import com.example.biblio.model.entity.Statut;
import com.example.biblio.repository.ReservationRepository;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReservationService {
    @Autowired
    private ReservationRepository reservationRepository;

    public Reservation save(Reservation reservation) {
        return reservationRepository.save(reservation);
    }

    public Reservation reserver(Adherent adherent, Exemplaire exemplaire, LocalDate dateReservation, Statut statut) {
    Reservation reservation = new Reservation();
    reservation.setAdherent(adherent);
    reservation.setExemplaire(exemplaire);
    reservation.setDateReservation(dateReservation);
    reservation.setStatut(statut);
    return reservationRepository.save(reservation);
}
} 
