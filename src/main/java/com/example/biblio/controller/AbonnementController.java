package com.example.biblio.controller;

import com.example.biblio.entity.Abonnement;
import com.example.biblio.model.entity.Adherent;
import com.example.biblio.service.AbonnementService;
import com.example.biblio.service.AdherentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/abonnements")
public class AbonnementController {
    
    @Autowired
    private AbonnementService abonnementService;
    
    @Autowired
    private AdherentService adherentService;
    
    // Afficher la liste des abonnements
    @GetMapping
    public String listeAbonnements(Model model) {
        List<Abonnement> abonnements = abonnementService.getAllAbonnements();
        model.addAttribute("abonnements", abonnements);
        return "abonnement/liste";
    }
    
    // Afficher le formulaire de création d'abonnement
    @GetMapping("/nouveau")
    public String nouveauAbonnement(Model model) {
        model.addAttribute("abonnement", new Abonnement());
        model.addAttribute("adherents", adherentService.findAll());
        return "abonnement/form";
    }
    
    // Créer un nouvel abonnement
    @PostMapping("/creer")
    public String creerAbonnement(@RequestParam Long idAdherent,
                                 @RequestParam String typeAbonnement,
                                 @RequestParam String dateDebut,
                                 @RequestParam String dateFin,
                                 @RequestParam BigDecimal prix,
                                 @RequestParam(required = false) Boolean autoRenouvellement,
                                 RedirectAttributes redirectAttributes) {
        try {
            Adherent adherent = adherentService.findById(idAdherent)
                .orElseThrow(() -> new RuntimeException("Adhérent non trouvé"));
            
            LocalDate debut = LocalDate.parse(dateDebut);
            LocalDate fin = LocalDate.parse(dateFin);
            
            Abonnement abonnement = abonnementService.creerAbonnement(adherent, typeAbonnement, debut, fin, prix);
            if (autoRenouvellement != null && autoRenouvellement) {
                abonnement.setAutoRenouvellement(true);
                abonnementService.saveAbonnement(abonnement);
            }
            
            redirectAttributes.addFlashAttribute("success", "Abonnement créé avec succès!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la création: " + e.getMessage());
        }
        
        return "redirect:/abonnements";
    }
    
    // Afficher les détails d'un abonnement
    @GetMapping("/{id}")
    public String detailsAbonnement(@PathVariable Long id, Model model) {
        Abonnement abonnement = abonnementService.getAbonnementById(id)
            .orElseThrow(() -> new RuntimeException("Abonnement non trouvé"));
        model.addAttribute("abonnement", abonnement);
        return "abonnement/details";
    }
    
    // Renouveler un abonnement
    @PostMapping("/{id}/renouveler")
    public String renouvellerAbonnement(@PathVariable Long id,
                                       @RequestParam String nouvelleDateFin,
                                       RedirectAttributes redirectAttributes) {
        try {
            LocalDate dateFin = LocalDate.parse(nouvelleDateFin);
            abonnementService.renouvellerAbonnement(id, dateFin);
            redirectAttributes.addFlashAttribute("success", "Abonnement renouvelé avec succès!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors du renouvellement: " + e.getMessage());
        }
        
        return "redirect:/abonnements/" + id;
    }
    
    // Résilier un abonnement
    @PostMapping("/{id}/resilier")
    public String resilierAbonnement(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            abonnementService.resilierAbonnement(id);
            redirectAttributes.addFlashAttribute("success", "Abonnement résilié avec succès!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la résiliation: " + e.getMessage());
        }
        
        return "redirect:/abonnements";
    }
    
    // Afficher les abonnements d'un adhérent
    @GetMapping("/adherent/{idAdherent}")
    public String abonnementsAdherent(@PathVariable Long idAdherent, Model model) {
        Adherent adherent = adherentService.findById(idAdherent)
            .orElseThrow(() -> new RuntimeException("Adhérent non trouvé"));
        
        List<Abonnement> abonnements = abonnementService.getAbonnementsByAdherent(adherent);
        model.addAttribute("adherent", adherent);
        model.addAttribute("abonnements", abonnements);
        return "abonnement/adherent-abonnements";
    }
    
    // Afficher les abonnements qui expirent bientôt
    @GetMapping("/expirant")
    public String abonnementsExpirant(Model model) {
        List<Abonnement> abonnements = abonnementService.getAbonnementsExpirantBientot();
        model.addAttribute("abonnements", abonnements);
        return "abonnement/expirant";
    }
}