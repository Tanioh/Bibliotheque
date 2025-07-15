package com.example.biblio.controller;

import com.example.biblio.model.entity.Adherent;
import com.example.biblio.model.entity.Pret;
import com.example.biblio.repository.PretRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/mes-prets")
public class AdherentPretController {
    @Autowired
    private PretRepository pretRepository;

    @GetMapping
    public String mesPrets(Model model, HttpSession session) {
        Adherent adherent = (Adherent) session.getAttribute("adherent");
        if (adherent == null) {
            return "redirect:/login-adherent";
        }
        
        // Pour l'instant, on affiche tous les prêts de l'adhérent
        // Dans une version future, on pourrait filtrer par statut
        List<Pret> prets = pretRepository.findAll().stream()
            .filter(p -> p.getAdherent().getIdAdherent().equals(adherent.getIdAdherent()))
            .toList();
            
        model.addAttribute("prets", prets);
        model.addAttribute("adherent", adherent);
        return "mes-prets";
    }
}