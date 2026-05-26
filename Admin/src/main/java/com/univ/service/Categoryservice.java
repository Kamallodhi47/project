package com.univ.service;


import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import com.univ.Repository.Categoryrepo;
import com.univ.entity.Category;

@Service
public class Categoryservice {
	
	 @Autowired
	    private Categoryrepo categoryrepo;

	    public Category saveCategory(Category category) {
	        return categoryrepo.save(category);
	    }

	    public Boolean existCategory(String name) {
	        return categoryrepo.existsByName(name);
	    }

		/*
		 * public List<Category> getAllCategories() { return
		 * categoryrepo.findByIsActiveTrue(); }
		 */

		public List<Category> getActiveCategories() {
			// TODO Auto-generated method stub
			return categoryrepo.findByIsActiveTrue();
		}

		public List<Category> getAllCategory() {
			
			// TODO Auto-generated method stub
			return categoryrepo.findAll(); 
		}
		public Page<Category> getAllCategorPagination(Integer pageNo, Integer pageSize) {
			Pageable pageable = PageRequest.of(pageNo, pageSize);
			return categoryrepo.findAll(pageable);
		}

		public Category getCategoryById(int id) {
			Category category = categoryrepo.findById(id).orElse(null);
			return category;
		}

		public Boolean deleteCategory(int id) {
			Category category = categoryrepo.findById(id).orElse(null);

			if (!ObjectUtils.isEmpty(category)) {
				categoryrepo.delete(category);
				return true;
			}
			return false;
		}

		public List<Category> findAll() {
			// TODO Auto-generated method stub
			return categoryrepo.findAll();
		}

		
	   
}
