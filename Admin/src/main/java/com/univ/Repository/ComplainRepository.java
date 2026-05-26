package com.univ.Repository;

import java.time.LocalDateTime;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.univ.entity.Complain;

public interface ComplainRepository extends JpaRepository<Complain, Integer> {

    // Filter complaints by status
    Page<Complain> findByStatus(String status, Pageable pageable);

    // Search complaints by subject or message (case-insensitive)
    @Query("SELECT c FROM Complain c WHERE LOWER(c.subject) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(c.message) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<Complain> searchComplaints(@Param("keyword") String keyword, Pageable pageable);

    // Filter complaints by createdAt date range
    @Query("SELECT c FROM Complain c WHERE c.createdAt BETWEEN :from AND :to")
    Page<Complain> findByDateRange(@Param("from") LocalDateTime from, @Param("to") LocalDateTime to, Pageable pageable);

    // Count complaints by status
    long countByStatus(String status);
}
