package com.univ.Repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.univ.entity.Offer;

@Repository
public interface OfferRepository extends JpaRepository< Offer, Integer> {

	 // Active Offer Fetch
	@Query("""
		    SELECT o FROM Offer o
		    WHERE o.active = true
		    AND o.startDate <= :now
		    AND o.endDate >= :now
		    ORDER BY o.priority DESC
		""")
		List<Offer> findActiveOffers(LocalDateTime now);
   }