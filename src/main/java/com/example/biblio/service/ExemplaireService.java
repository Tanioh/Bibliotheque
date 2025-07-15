package com.example.biblio.service;

import com.example.biblio.model.entity.Exemplaire;
import com.example.biblio.repository.ExemplaireRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ExemplaireService {
    @Autowired
    private ExemplaireRepository exemplaireRepository;

    public List<Exemplaire> findAllDisponibles() {
        return exemplaireRepository.findByDisponibleTrue();
    }
}