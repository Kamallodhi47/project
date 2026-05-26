package com.univ.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.univ.entity.Offer;
import com.univ.entity.OfferUsage;

import jakarta.transaction.Transactional;

public interface OfferUsageRepository extends JpaRepository<OfferUsage, Integer> {

    @Query("SELECT ou.offer.id FROM OfferUsage ou WHERE ou.userId = :userId AND ou.offer.id IN :offerIds AND ou.used = true")
    List<Integer> findUsedOfferIdsByUserId(@Param("userId") Integer userId,
                                           @Param("offerIds") List<Integer> offerIds);

    boolean existsByUserIdAndOffer_Id(Integer userId, Integer offerId);

    boolean existsByUserIdAndUsedTrue(Integer userId);

    Integer countByUserIdAndOffer_Id(Integer userId, Integer offerId);

    @Query("SELECT o FROM Offer o JOIN OfferUsage ou ON o.id = ou.offer.id WHERE ou.userId = :userId")
    List<Offer> findOffersByUserId(@Param("userId") Integer userId);

    int countByUserId(Integer userId);

    @Modifying
    @Transactional
    @Query("DELETE FROM OfferUsage ou WHERE ou.offer.id = :offerId")
    void deleteByOfferId(Integer offerId);
}