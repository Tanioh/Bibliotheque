package com.example.biblio.service;

import com.example.biblio.model.entity.Adherent;
import com.example.biblio.repository.AdherentRepository;
import com.example.biblio.repository.PretRepository;
import com.example.biblio.repository.ReservationRepository;
import com.example.biblio.repository.PenaliteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class AdherentService {
    @Autowired
    private AdherentRepository adherentRepository;
    
    @Autowired
    private PretRepository pretRepository;
    
    @Autowired
    private ReservationRepository reservationRepository;
    
    @Autowired
    private PenaliteRepository penaliteRepository;

    public List<Adherent> findAll() {
        return adherentRepository.findAll();
    }

    public Optional<Adherent> findById(Long id) {
        return adherentRepository.findById(id);
    }

    public Adherent save(Adherent adherent) {
        return adherentRepository.save(adherent);
    }

    @Transactional
    public void deleteById(Long id) {
        Optional<Adherent> adherentOpt = adherentRepository.findById(id);
        if (adherentOpt.isPresent()) {
            Adherent adherent = adherentOpt.get();
            
            // Supprimer d'abord toutes les données liées
            pretRepository.deleteByAdherent(adherent);
            reservationRepository.deleteByAdherent(adherent);
            penaliteRepository.deleteByAdherent(adherent);
            
            // Puis supprimer l'adhérent
            adherentRepository.deleteById(id);
        }
    }
}
