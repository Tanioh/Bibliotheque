package com.example.biblio.service;

import com.example.biblio.model.entity.Pret;
import com.example.biblio.model.entity.Prolongement;
import com.example.biblio.model.entity.Statut;
import com.example.biblio.repository.ProlongementRepository;
import com.example.biblio.repository.PretRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
public class ProlongementService {
    @Autowired
    private ProlongementRepository prolongementRepository;
    @Autowired
    private PretRepository pretRepository;

    public Prolongement demanderProlongement(Long pretId, LocalDate nouvelleDateRetour, Statut statut) {
        Pret pret = pretRepository.findById(pretId).orElseThrow();
        Prolongement prolongement = new Prolongement();
        prolongement.setPret(pret);
        prolongement.setDateProlongement(LocalDate.now());
        prolongement.setNouvelleDateRetour(nouvelleDateRetour);
        prolongement.setStatut(statut);
        // Mettre à jour la date de retour prévue du prêt
        pret.setDateRetourPrevue(nouvelleDateRetour);
        pretRepository.save(pret);
        return prolongementRepository.save(prolongement);
    }
}