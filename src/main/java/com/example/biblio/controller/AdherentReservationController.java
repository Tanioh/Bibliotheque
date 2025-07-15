package com.example.biblio.controller;

import com.example.biblio.model.entity.Adherent;
import com.example.biblio.model.entity.Reservation;
import com.example.biblio.repository.ReservationRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/mes-reservations")
public class AdherentReservationController {
    @Autowired
    private ReservationRepository reservationRepository;

    @GetMapping
    public String mesReservations(Model model, HttpSession session) {
        Adherent adherent = (Adherent) session.getAttribute("adherent");
        if (adherent == null) {
            return "redirect:/login-adherent";
        }
        
        List<Reservation> reservations = reservationRepository.findAll().stream()
            .filter(r -> r.getAdherent().getIdAdherent().equals(adherent.getIdAdherent()))
            .toList();
            
        model.addAttribute("reservations", reservations);
        model.addAttribute("adherent", adherent);
        return "mes-reservations";
    }
}