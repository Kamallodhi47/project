package com.univ.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.univ.Repository.OfferRepository;
import com.univ.Repository.OfferUsageRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Service
public class OfferService {

    private final OfferRepository offerRepository;
    private final OfferUsageRepository offerUsageRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public OfferService(OfferRepository offerRepository,
                        OfferUsageRepository offerUsageRepository) {

        this.offerRepository = offerRepository;
        this.offerUsageRepository = offerUsageRepository;
    }

    // 🔥 FINAL DELETE METHOD
    @Transactional
    public void deleteOffer(Integer id) {

        // ✅ 1. delete usage
        offerUsageRepository.deleteByOfferId(id);

        // ✅ 2. delete join tables
        entityManager.createNativeQuery("DELETE FROM offer_eligible_products WHERE offer_id = :id")
                .setParameter("id", id)
                .executeUpdate();

        entityManager.createNativeQuery("DELETE FROM offer_free_products WHERE offer_id = :id")
                .setParameter("id", id)
                .executeUpdate();

        // ✅ 3. delete main offer
        offerRepository.deleteById(id);
    }
}