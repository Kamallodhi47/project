package com.univ.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.univ.entity.Category;
import com.univ.service.Categoryservice;

import jakarta.servlet.http.HttpSession;
@RestController
@RequestMapping("/api/categories")
public class RestAdmin {

// private final String adminApiUrl = "http://localhost:8080/api/categories";
 
@Autowired
private Categoryservice categoryservice;
@GetMapping("/active")
public List<Category> getActiveCategories() {
   
	return categoryservice.getActiveCategories();
}



}
 


