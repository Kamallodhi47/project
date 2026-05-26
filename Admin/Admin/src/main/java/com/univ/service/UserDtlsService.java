package com.univ.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.Repository.userRepo;
import com.univ.entity.UserDtls;

@Service
public class UserDtlsService {
	 @Autowired
	    private userRepo userRepo;

	    public long countAllUsers() {
	        return userRepo.count();
	    }
	

	    public UserDtls registerUser(UserDtls user) {

	        UserDtls existUser = userRepo.findByEmail(user.getEmail());

	        if (existUser != null) {
	            return null;
	        }

	        user.setRole("ROLE_Admin");
	        user.setIsEnable(true);
	        user.setAccountNonLocked(true);
	        user.setFailedAttempt(0);
	        user.setNewUser(true);

	        return userRepo.save(user);
	    }


	    public UserDtls findByEmail(String email) {
	        return userRepo.findByEmail(email);
	    }
	   }
