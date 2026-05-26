package com.univ.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.Repository.ComplainRepo;
import com.univ.entity.Complain;

import com.univ.service.ComplainService;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ComplainService  {
       @Autowired
       private ComplainRepo complainRepository;

    
		/*
		 * public Complain saveComplaint(Complain complain) { return
		 * complainRepository.save(complain); }
		 */

       public boolean existsByOrderId(Integer orderId) {
           return complainRepository.existsByOrderId(orderId);
       }
       @Transactional
       public void saveComplaint(Complain complain) {
           // save() kaam karta hai insert & update dono ke liye
           complainRepository.save(complain);
           complainRepository.flush();
       }
     
       public Optional<Complain> getComplaintByOrderIdAndUserId(Integer orderId, Integer userId) {
           return complainRepository.findByOrderIdAndUserId(orderId, userId);
       }
       public Optional<Complain> getComplaintById(Integer complaintId) {
           return complainRepository.findById(complaintId);
       }
	  	   public Optional<Complain> getLatestComplaintByUserId(Integer userId) {
	        return  complainRepository.findFirstByUserIdOrderByComplaintDateDesc(userId);
	    }
		  
       }
