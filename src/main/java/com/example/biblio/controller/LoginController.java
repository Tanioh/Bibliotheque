package com.example.biblio.controller;

import com.example.biblio.model.entity.Adherent;
import com.example.biblio.service.AdherentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {
    @Autowired
    private AdherentService adherentService;

    @GetMapping
    public String showLoginForm() {
        return "login";
    }

    @PostMapping
    public String login(@RequestParam String nom, @RequestParam String email, HttpSession session, Model model) {
        Adherent adherent = adherentService.findAll().stream()
                .filter(a -> a.getNom().equalsIgnoreCase(nom) && a.getEmail().equalsIgnoreCase(email))
                .findFirst().orElse(null);
        if (adherent != null) {
            session.setAttribute("adherent", adherent);
            return "redirect:/adherents";
        } else {
            model.addAttribute("error", "Nom ou email incorrect");
            return "login";
        }
    }

}
