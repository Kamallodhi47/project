package com.univ.Repository;

import java.time.LocalDateTime;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.univ.entity.OrderDtls;

public interface OrderDtlsRepository extends JpaRepository<OrderDtls, Integer>, JpaSpecificationExecutor<OrderDtls> {

    // -------- COUNT --------
    long countByStatus(String status);

    // -------- TOTAL REVENUE --------
    @Query("SELECT COALESCE(SUM(o.grandTotal), 0) FROM OrderDtls o")
    double getTotalRevenue();

    // -------- MONTHLY REVENUE --------
    @Query("""
        SELECT COALESCE(SUM(o.grandTotal), 0)
        FROM OrderDtls o
        WHERE o.orderDate >= :startDate
    """)
    double getMonthlyRevenue(@Param("startDate") LocalDateTime startDate);

    // -------- WEEKLY REVENUE --------
    @Query("""
        SELECT COALESCE(SUM(o.grandTotal), 0)
        FROM OrderDtls o
        WHERE o.orderDate >= :startDate
    """)
    double getWeeklyRevenue(@Param("startDate") LocalDateTime startDate);

    // -------- AVERAGE ORDER VALUE --------
    @Query("SELECT COALESCE(AVG(o.grandTotal), 0) FROM OrderDtls o")
    double getAverageOrderValue();

    // -------- FIND BY ORDER ID --------
    OrderDtls findByOrderId(String orderId);

    // -------- FILTERED ORDERS (FIXED VERSION) --------
    @Query("""
        SELECT o FROM OrderDtls o 
        LEFT JOIN FETCH o.user u
        WHERE (COALESCE(:search, '') = '' 
               OR LOWER(o.orderId) LIKE LOWER(CONCAT('%', :search, '%')) 
               OR LOWER(o.userName) LIKE LOWER(CONCAT('%', :search, '%'))
               OR LOWER(u.name) LIKE LOWER(CONCAT('%', :search, '%'))
               OR LOWER(u.email) LIKE LOWER(CONCAT('%', :search, '%'))
               OR LOWER(u.mobileNumber) LIKE LOWER(CONCAT('%', :search, '%')))
          AND (COALESCE(:status, '') = '' OR o.status = :status)
          AND (:startDate IS NULL OR o.orderDate >= :startDate)
          AND (:endDate IS NULL OR o.orderDate <= :endDate)
        ORDER BY o.orderDate DESC
    """)
    Page<OrderDtls> findOrdersWithFilters(
            @Param("search") String search,
            @Param("status") String status,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate,
            Pageable pageable
    );
    
    // -------- SIMPLIFIED FILTER METHOD (ALTERNATIVE) --------
    @Query("""
        SELECT o FROM OrderDtls o
        WHERE (LOWER(o.orderId) LIKE LOWER(CONCAT('%', COALESCE(:search, ''), '%'))
               OR LOWER(o.userName) LIKE LOWER(CONCAT('%', COALESCE(:search, ''), '%')))
          AND (:status IS NULL OR o.status = :status)
          AND (:startDate IS NULL OR o.orderDate >= :startDate)
          AND (:endDate IS NULL OR o.orderDate <= :endDate)
    """)
    Page<OrderDtls> findSimpleFilteredOrders(
            @Param("search") String search,
            @Param("status") String status,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate,
            Pageable pageable
    );
}