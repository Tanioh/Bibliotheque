package com.example.biblio.controller;

import com.example.biblio.model.entity.Adherent;
import com.example.biblio.model.entity.Profil;
import com.example.biblio.model.entity.Penalite;
import com.example.biblio.service.AdherentService;
import com.example.biblio.repository.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/adherents")
public class AdherentController {
    @Autowired
    private AdherentService adherentService;

    @Autowired
    private ProfilRepository profilRepository;
    
    @Autowired
    private PretRepository pretRepository;
    
    @Autowired
    private PenaliteRepository penaliteRepository;

    @GetMapping
    public String listAdherents(Model model) {
        model.addAttribute("adherents", adherentService.findAll());
        return "liste"; // Correspond à WEB-INF/views/liste.jsp
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("adherent", new Adherent());
        model.addAttribute("profils", profilRepository.findAll());
        return "form"; // Correspond à WEB-INF/views/form.jsp
    }

    @PostMapping
    public String createAdherent(@ModelAttribute Adherent adherent, @RequestParam Long profilId, Model model) {
        try {
            Profil profil = profilRepository.findById(profilId).orElseThrow();
            adherent.setProfil(profil);
            adherentService.save(adherent);
            return "redirect:/adherents";
        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            model.addAttribute("adherent", adherent);
            model.addAttribute("profils", profilRepository.findAll());
            model.addAttribute("error", "Cet email est déjà utilisé par un autre adhérent. Veuillez utiliser un email différent.");
            return "form";
        }
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        model.addAttribute("adherent",
                adherentService.findById(id).orElseThrow(() -> new IllegalArgumentException("Adhérent non trouvé")));
        model.addAttribute("profils", profilRepository.findAll());
        return "form"; // Correspond à WEB-INF/views/form.jsp
    }

    @PostMapping("/update/{id}")
    public String updateAdherent(@PathVariable Long id, @ModelAttribute Adherent adherent) {
        adherent.setIdAdherent(id);
        adherentService.save(adherent);
        return "redirect:/adherents";
    }

    @GetMapping("/delete/{id}")
    public String deleteAdherent(@PathVariable Long id, Model model) {
        try {
            adherentService.deleteById(id);
            return "redirect:/adherents";
        } catch (Exception e) {
            model.addAttribute("adherents", adherentService.findAll());
            model.addAttribute("error", "Impossible de supprimer cet adhérent. Il pourrait avoir des données associées.");
            return "liste";
        }
    }

    @GetMapping("/{id:\\d+}")
    public String viewAdherent(@PathVariable Long id, Model model) {
        Adherent adherent = adherentService.findById(id).orElseThrow(() -> new IllegalArgumentException("Adhérent non trouvé"));
        
        // Calculer le quota restant
        long nbPretsEnCours = pretRepository.countByAdherentAndStatut_Libelle(adherent, "en_cours");
        int quotaMax = adherent.getProfil() != null ? adherent.getProfil().getQuotaMaxPret() : 0;
        int quotaRestant = Math.max(0, quotaMax - (int)nbPretsEnCours);
        
        // Vérifier les pénalités actives
        boolean estPenalise = penaliteRepository.existsByAdherentAndLeveeFalseAndDateFinAfter(adherent, LocalDate.now());
        Penalite penaliteActive = null;
        long joursRestantsPenalite = 0;
        
        if (estPenalise) {
            penaliteActive = penaliteRepository.findFirstByAdherentAndLeveeFalseOrderByDatePenaliteDesc(adherent).orElse(null);
            if (penaliteActive != null && penaliteActive.getDateFin() != null) {
                joursRestantsPenalite = ChronoUnit.DAYS.between(LocalDate.now(), penaliteActive.getDateFin());
                joursRestantsPenalite = Math.max(0, joursRestantsPenalite); // Éviter les valeurs négatives
            }
        }
        
        model.addAttribute("adherent", adherent);
        model.addAttribute("nbPretsEnCours", nbPretsEnCours);
        model.addAttribute("quotaMax", quotaMax);
        model.addAttribute("quotaRestant", quotaRestant);
        model.addAttribute("estPenalise", estPenalise);
        model.addAttribute("penaliteActive", penaliteActive);
        model.addAttribute("joursRestantsPenalite", joursRestantsPenalite);
        
        return "detail";
    }
    
    @PostMapping("/{id}/annuler-penalite")
    public String annulerPenalite(@PathVariable Long id, Model model) {
        try {
            Adherent adherent = adherentService.findById(id).orElseThrow(() -> new IllegalArgumentException("Adhérent non trouvé"));
            
            // Trouver la pénalité active et la marquer comme levée
            Penalite penaliteActive = penaliteRepository.findFirstByAdherentAndLeveeFalseOrderByDatePenaliteDesc(adherent).orElse(null);
            if (penaliteActive != null) {
                penaliteActive.setLevee(true);
                penaliteRepository.save(penaliteActive);
            }
            
            return "redirect:/adherents/" + id + "?penalite-annulee";
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de l'annulation de la pénalité: " + e.getMessage());
            return "redirect:/adherents/" + id + "?error";
        }
    }
}