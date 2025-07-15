package com.example.biblio.controller;

import com.example.biblio.service.ExemplaireService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/liste-exemplaires")
public class ExemplaireController {
    @Autowired
    private ExemplaireService exemplaireService;

    @GetMapping
    public String listExemplairesDisponibles(Model model) {
        model.addAttribute("exemplaires", exemplaireService.findAllDisponibles());
        return "liste-exemplaires"; // Correspond à WEB-INF/views/liste-exemplaires.jsp
    }
}
