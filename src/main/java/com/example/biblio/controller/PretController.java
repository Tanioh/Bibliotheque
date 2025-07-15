package com.example.biblio.controller;

import com.example.biblio.model.entity.Adherent;
import com.example.biblio.model.entity.Exemplaire;
import com.example.biblio.model.entity.Pret;
import com.example.biblio.model.entity.Emplacement;
import com.example.biblio.model.entity.Statut;
import com.example.biblio.repository.AdherentRepository;
import com.example.biblio.repository.ExemplaireRepository;
import com.example.biblio.repository.EmplacementRepository;
import com.example.biblio.repository.StatutRepository;
import com.example.biblio.repository.PretRepository;
import com.example.biblio.service.PretService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Controller
@RequestMapping("/prets")
public class PretController {
    @Autowired
    private PretService pretService;
    @Autowired
    private PretRepository pretRepository;
    @Autowired
    private AdherentRepository adherentRepository;
    @Autowired
    private ExemplaireRepository exemplaireRepository;
    @Autowired
    private EmplacementRepository emplacementRepository;
    @Autowired
    private StatutRepository statutRepository;

    @GetMapping("/new")
    public String showPretForm(Model model) {
        model.addAttribute("adherents", adherentRepository.findAll());
        model.addAttribute("exemplaires", exemplaireRepository.findByDisponibleTrue());
        model.addAttribute("emplacements", emplacementRepository.findAll());
        model.addAttribute("statuts", statutRepository.findAll());
        return "pret-form";
    }

    @GetMapping("/return")
    public String showReturnForm(Model model) {
        model.addAttribute("adherents", adherentRepository.findAll());
        model.addAttribute("prets", pretRepository.findAll());
        return "pret-return-form";
    }

    @PostMapping
    public String fairePret(
        @RequestParam Long adherentId,
        @RequestParam Long exemplaireId,
        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate datePret,
        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateRetourPrevue,
        @RequestParam Long emplacementId,
        Model model) {

    Adherent adherent = adherentRepository.findById(adherentId).orElseThrow();
    Exemplaire exemplaire = exemplaireRepository.findById(exemplaireId).orElseThrow();
    Emplacement emplacement = emplacementRepository.findById(emplacementId).orElseThrow();
    Statut statut = statutRepository.findByLibelle("en_cours").orElseThrow();

    try {
        pretService.fairePret(adherent, exemplaire, datePret, dateRetourPrevue, emplacement, statut);
        return "redirect:/prets/new?success";
    } catch (IllegalStateException e) {
        model.addAttribute("adherents", adherentRepository.findAll());
        model.addAttribute("exemplaires", exemplaireRepository.findByDisponibleTrue());
        model.addAttribute("emplacements", emplacementRepository.findAll());
        model.addAttribute("statuts", statutRepository.findAll());
        model.addAttribute("error", e.getMessage());
        return "pret-form";
    }
}

    @PostMapping("/return")
    public String rendrePret(
            @RequestParam Long pretId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateRendu,
            Model model) {

        Pret pret = pretRepository.findById(pretId).orElseThrow();
        String message = pretService.rendrePret(pret, dateRendu);

        model.addAttribute("adherents", adherentRepository.findAll());
        model.addAttribute("prets", pretRepository.findAll());
        model.addAttribute("message", message);
        return "pret-return-form";
    }

}