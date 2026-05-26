package com.univ.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.univ.entity.Offer;
import com.univ.entity.OfferType;
import com.univ.entity.OfferUsage;
import com.univ.entity.Product;

import com.univ.Repository.CartRepository;
import com.univ.Repository.OfferRepository;
import com.univ.Repository.OfferUsageRepository;

@Service
public class OfferEngineService {

    private final OfferRepository offerRepository;
    private final CartRepository cartRepository;
    private final OfferUsageRepository offerUsageRepository;

    public OfferEngineService(OfferRepository offerRepository,
                              CartRepository cartRepository,
                              OfferUsageRepository offerUsageRepository) {

        this.offerRepository = offerRepository;
        this.cartRepository = cartRepository;
        this.offerUsageRepository = offerUsageRepository;
    }

    public List<Product> getFreeProductOptions(Integer userId) {

        if (offerUsageRepository.existsByUserIdAndUsedTrue(userId)) {
            return List.of();
        }

        List<Offer> offers = offerRepository.findActiveOffers(LocalDateTime.now());

        for (Offer offer : offers) {

            if (offer.getOfferType() == OfferType.BOGO ||
                offer.getOfferType() == OfferType.ADD_TO_CART_FREE_CHOICE) {

                if (offer.getFreeProducts() != null && !offer.getFreeProducts().isEmpty()) {
                    return offer.getFreeProducts();
                }
            }
        }

        return List.of();
    }

    public void lockOffer(Integer userId, Integer offerId) {

        if (offerUsageRepository.existsByUserIdAndOfferId(userId, offerId)) {
            return;
        }

        Offer offer = offerRepository.findById(offerId)
                .orElseThrow(() -> new RuntimeException("Offer not found"));

        OfferUsage usage = new OfferUsage();
        usage.setUserId(userId);
        usage.setOffer(offer); // ✅ correct relation
        usage.setUsed(true);
        usage.setUsedAt(LocalDateTime.now());

        offerUsageRepository.save(usage);
    }
}