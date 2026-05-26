package com.univ.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.univ.entity.Product;

public interface ProductRepo extends JpaRepository<Product, Integer> {
	List<Product> findByIsActiveTrueOrderByDiscountDesc();

    List<Product> findByIsActiveTrueOrderByIdDesc();

}
