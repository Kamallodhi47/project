package com.univ.Repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.univ.entity.Category;

public interface CategoryRepo extends JpaRepository<Category, Integer> {

}
