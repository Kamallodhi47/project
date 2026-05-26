package com.univ.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.univ.Repository.ComplainRepository;
import com.univ.entity.Complain;

@Service
public class ComplainService {

    @Autowired
    private ComplainRepository complainRepository;

    public Page<Complain> getComplaints(String status, String search, LocalDateTime from, LocalDateTime to, Pageable pageable) {
        if (status != null && !status.isEmpty()) {
            return complainRepository.findByStatus(status, pageable);
        } else if (search != null && !search.isEmpty()) {
            return complainRepository.searchComplaints(search.toLowerCase(), pageable);
        } else if (from != null && to != null) {
            return complainRepository.findByDateRange(from, to, pageable);
        } else {
            return complainRepository.findAll(pageable);
        }
    }

    public long countByStatus(String status) {
        return complainRepository.countByStatus(status);
    }

    public long countAllComplaints() {
        return complainRepository.count(); // JpaRepository ka built-in count()
    }

    public long count() {
        return complainRepository.count(); // repository ka built-in count() method
    }

    public Complain getById(Integer id) {
        return complainRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Complaint not found with id: " + id));
    }

   
	

    // Optional: count by status
  
}
