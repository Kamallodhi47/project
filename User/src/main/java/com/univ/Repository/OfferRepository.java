package com.univ.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.univ.entity.Offer;

@Repository
public interface OfferRepository extends JpaRepository<Offer, Integer> {

    @Query("""
        SELECT COUNT(o) > 0
        FROM OfferUsage o
        WHERE o.userId = :userId
        AND o.offer.offerType = com.univ.entity.OfferType.NEW_USER_FREE_PRODUCT
    """)
    boolean hasUsedNewUserOffer(Integer userId);

    @Query("""
        SELECT o FROM Offer o
        WHERE o.active = true
        AND (o.startDate IS NULL OR o.startDate <= :now)
        AND (o.endDate IS NULL OR o.endDate >= :now)
    """)
    List<Offer> findAllActiveOffers(LocalDateTime now);

	

	Optional<Offer> findFirstByActiveTrueOrderByPriorityDesc();
}