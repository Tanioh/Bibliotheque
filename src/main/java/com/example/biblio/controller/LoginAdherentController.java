package com.example.biblio.controller;

import com.example.biblio.model.entity.Adherent;
import com.example.biblio.repository.AdherentRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginAdherentController {
    @Autowired
    private AdherentRepository adherentRepository;

    @GetMapping("/login-adherent")
    public String showLoginForm() {
        return "login-adherent";
    }

    @PostMapping("/login-adherent")
    public String loginAdherent(@RequestParam String nom, @RequestParam String email, HttpSession session,
            Model model) {
        Adherent adherent = adherentRepository.findAll().stream()
                .filter(a -> a.getNom().equalsIgnoreCase(nom) && a.getEmail().equalsIgnoreCase(email))
                .findFirst().orElse(null);
        if (adherent != null) {
            session.setAttribute("adherent", adherent);
            return "redirect:/liste-exemplaires"; // Redirige vers la liste des exemplaires
        } else {
            model.addAttribute("error", "Nom ou email incorrect");
            return "login-adherent";
        }
    }
}
