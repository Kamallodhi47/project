package com.univ.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.univ.entity.Product;
import com.univ.service.Productservice;

@RestController
@RequestMapping("api/products")  // ✔ Correct, base path for products
public class RestProduct {
    
    @Autowired
    private Productservice productservice;  // ✔ Must be @Service and a Spring Bean
    
    @GetMapping("/active")  // ✔ URL will be /api/products/active
    public List<Product> getActiveProducts() {
        return productservice.getActiveProducts();  // ✔ Must return List<Product>
    }
}
