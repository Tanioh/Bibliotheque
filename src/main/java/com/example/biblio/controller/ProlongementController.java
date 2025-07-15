package com.example.biblio.controller;

import com.example.biblio.model.entity.Pret;
import com.example.biblio.model.entity.Statut;
import com.example.biblio.service.ProlongementService;
import com.example.biblio.repository.PretRepository;
import com.example.biblio.repository.StatutRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Controller
@RequestMapping("/prolongement")
public class ProlongementController {
    @Autowired
    private ProlongementService prolongementService;
    @Autowired
    private PretRepository pretRepository;
    @Autowired
    private StatutRepository statutRepository;

    @GetMapping("/form/{pretId}")
    public String showProlongementForm(@PathVariable Long pretId, Model model, HttpSession session) {
        Pret pret = pretRepository.findById(pretId).orElseThrow();
        model.addAttribute("pret", pret);
        return "prolongement-form";
    }

    @PostMapping("/{pretId}")
    public String demanderProlongement(
            @PathVariable Long pretId,
            @RequestParam("nouvelleDateRetour") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate nouvelleDateRetour,
            Model model) {
        Statut statut = statutRepository.findByLibelle("en_cours").orElseThrow();
        prolongementService.demanderProlongement(pretId, nouvelleDateRetour, statut);
        model.addAttribute("message", "Prolongement demandé avec succès !");
        return "redirect:/adherents"; // ou la page de suivi des prêts
    }
}