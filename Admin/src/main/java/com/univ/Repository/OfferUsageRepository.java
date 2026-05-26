package com.univ.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.univ.entity.OfferUsage;

public interface OfferUsageRepository extends JpaRepository<OfferUsage, Integer> {
	 boolean existsByUserIdAndOfferId(Integer userId, Integer offerId);

	    boolean existsByUserIdAndUsedTrue(Integer userId);

		void deleteByOfferId(Integer id);


}
