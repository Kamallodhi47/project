package com.univ.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.Repository.SellerRepo;
import com.univ.entity.Seller;


@Service
public class Sellerservice  {
	
	
@Autowired
 private SellerRepo sellerrepo;
public Seller saveSeller(Seller seller)
{
	Seller sl=sellerrepo.save(seller);
		return sl;	
}

public Boolean existsEmail(String email) {
	return sellerrepo.existsByEmail(email);
}

}
