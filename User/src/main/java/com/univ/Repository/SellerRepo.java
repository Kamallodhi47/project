package com.univ.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.univ.entity.Seller;

public interface SellerRepo extends JpaRepository<Seller, Long> {
	public Boolean existsByEmail(String email);
	

}
