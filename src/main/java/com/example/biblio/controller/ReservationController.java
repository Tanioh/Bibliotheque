package com.example.biblio.controller;

import com.example.biblio.model.entity.Exemplaire;
import com.example.biblio.model.entity.Adherent;
import com.example.biblio.model.entity.Statut;
import com.example.biblio.service.ReservationService;
import com.example.biblio.repository.ExemplaireRepository;
import com.example.biblio.repository.StatutRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Controller
@RequestMapping("/reservation")
public class ReservationController {
    @Autowired
    private ReservationService reservationService;
    @Autowired
    private ExemplaireRepository exemplaireRepository;
    @Autowired
    private StatutRepository statutRepository;

    @GetMapping("/form/{idExemplaire}")
    public String showReservationForm(@PathVariable Long idExemplaire, Model model, HttpSession session) {
        Adherent adherent = (Adherent) session.getAttribute("adherent");
        if (adherent == null) {
            return "redirect:/login-adherent";
        }
        Exemplaire exemplaire = exemplaireRepository.findById(idExemplaire).orElseThrow();
        model.addAttribute("exemplaire", exemplaire);
        return "reservation-form";
    }

    @PostMapping("/{idExemplaire}")
    public String reserver(
            @PathVariable Long idExemplaire,
            @RequestParam("dateReservation") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateReservation,
            HttpSession session) {
        Adherent adherent = (Adherent) session.getAttribute("adherent");
        if (adherent == null) {
            return "redirect:/login-adherent";
        }
        Exemplaire exemplaire = exemplaireRepository.findById(idExemplaire).orElseThrow();
        Statut statut = statutRepository.findByLibelle("en_cours").orElseThrow();
        reservationService.reserver(adherent, exemplaire, dateReservation, statut);
        return "redirect:/liste-exemplaires";
    }
}