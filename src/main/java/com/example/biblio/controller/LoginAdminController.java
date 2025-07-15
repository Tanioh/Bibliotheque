package com.example.biblio.controller;

import com.example.biblio.model.entity.Admin;
import com.example.biblio.repository.AdminRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginAdminController {
    @Autowired
    private AdminRepository adminRepository;

    @GetMapping("/login-admin")
    public String showLoginForm() {
        return "login-admin";
    }

    @PostMapping("/login-admin")
    public String loginAdmin(@RequestParam String nom_utilisateur, @RequestParam String mot_de_passe,
            HttpSession session, Model model) {
        Admin admin = adminRepository.findAll().stream()
                .filter(a -> a.getNomUtilisateur().equalsIgnoreCase(nom_utilisateur)
                        && a.getMotDePasse().equals(mot_de_passe))
                .findFirst().orElse(null);
        if (admin != null) {
            session.setAttribute("admin", admin);
            return "redirect:/adherents";
        } else {
            model.addAttribute("error", "Nom d'utilisateur ou mot de passe incorrect");
            return "login-admin";
        }
    }
}
