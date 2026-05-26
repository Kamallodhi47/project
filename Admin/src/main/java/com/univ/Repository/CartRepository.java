package com.univ.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.univ.entity.Cart;

public interface CartRepository extends JpaRepository<Cart, Integer>{
	List<Cart> findByUserId(Integer userId);

    boolean existsByUserId(Integer userId);

}
