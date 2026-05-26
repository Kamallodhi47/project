package com.univ.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.univ.Repository.OrderDtlsRepository;
import com.univ.entity.OrderDtls;
import com.univ.entity.UserDtls;

import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import jakarta.persistence.criteria.Predicate;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class OrderDtlsService {

    @Autowired
    private OrderDtlsRepository orderRepository;
	private Pageable pageable;

    // -------- TOTAL ORDERS --------
    public long countAllOrders() {
        return orderRepository.count();
    }

    // -------- STATUS COUNT --------
    public long countByStatus(String status) {
        return orderRepository.countByStatus(status);
    }

    // -------- TOTAL REVENUE --------
    public double getTotalRevenue() {
        return orderRepository.getTotalRevenue();
    }

    // -------- WEEKLY REVENUE --------
    public double getWeeklyRevenue() {
        LocalDateTime startDate = LocalDate.now().minusDays(7).atStartOfDay();
        return orderRepository.getWeeklyRevenue(startDate);
    }

    // -------- MONTHLY REVENUE --------
    public double getMonthlyRevenue() {
        LocalDateTime startDate = LocalDate.now().withDayOfMonth(1).atStartOfDay();
        return orderRepository.getMonthlyRevenue(startDate);
    }

    // -------- AVERAGE ORDER VALUE --------
    public double getAverageOrderValue() {
        return orderRepository.getAverageOrderValue();
    }

    // -------- COMPLETE UPDATE STATUS METHOD --------
    public void updateOrderStatus(Integer orderId, String status, String cancellationReason) {
        System.out.println(">>> SERVICE METHOD HIT <<<");
        System.out.println("orderId = " + orderId);
        System.out.println("status = " + status);
        
        OrderDtls order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found with ID: " + orderId));

        LocalDateTime now = LocalDateTime.now();
        status = status.toUpperCase();

        order.setStatus(status);

        // Handle all status updates
        switch (status) {
            case "CONFIRMED":
                order.setConfirmedDate(now);
                break;
            case "SHIPPED":
                order.setShippedDate(now);
                break;
            case "DELIVERED":
                order.setDeliveredDate(now);
                break;
            case "CANCELLED":
                order.setCancelledDate(now);
                order.setCancellationReason(cancellationReason);
                break;
            case "PENDING":
                // Reset dates if going back to pending
                order.setConfirmedDate(null);
                order.setShippedDate(null);
                order.setDeliveredDate(null);
                order.setCancelledDate(null);
                order.setCancellationReason(null);
                break;
        }

        orderRepository.save(order);
        System.out.println("✅ Order #" + orderId + " updated to status: " + status);
    }

    // -------- GET FILTERED ORDERS - CORRECTED VERSION --------
    public Page<OrderDtls> getFilteredOrders(Integer pageNo, Integer pageSize, 
                                            String search, String status, 
                                            String dateRange) {
        try {
            Pageable pageable = PageRequest.of(pageNo, pageSize, Sort.by("orderDate").descending());
            
            // Create specification using method reference
            return orderRepository.findAll((root, query, cb) -> {
                List<Predicate> predicates = new ArrayList<>();
                
                // Search filter
                if (search != null && !search.trim().isEmpty()) {
                    String searchTerm = "%" + search.toLowerCase() + "%";
                    
                    // Join with user table
                    Join<OrderDtls, UserDtls> userJoin = root.join("user", JoinType.LEFT);
                    
                    Predicate searchPredicate = cb.or(
                        cb.like(cb.lower(root.get("orderId")), searchTerm),
                        cb.like(cb.lower(root.get("userName")), searchTerm),
                        cb.like(cb.lower(userJoin.get("name")), searchTerm),
                        cb.like(cb.lower(userJoin.get("email")), searchTerm),
                        cb.like(cb.lower(userJoin.get("mobileNumber")), searchTerm),
                        cb.like(cb.lower(root.get("paymentId")), searchTerm)
                    );
                    predicates.add(searchPredicate);
                }
                
                // Status filter
                if (status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("ALL")) {
                    predicates.add(cb.equal(cb.upper(root.get("status")), status.toUpperCase()));
                }
                
                // Date range filter
                if (dateRange != null && !dateRange.trim().isEmpty() && dateRange.contains(" - ")) {
                    try {
                        String[] dates = dateRange.split(" - ");
                        LocalDate startDate = LocalDate.parse(dates[0].trim());
                        LocalDate endDate = LocalDate.parse(dates[1].trim());
                        
                        LocalDateTime startDateTime = startDate.atStartOfDay();
                        LocalDateTime endDateTime = endDate.atTime(23, 59, 59);
                        
                        predicates.add(cb.between(root.get("orderDate"), startDateTime, endDateTime));
                    } catch (Exception e) {
                        System.err.println("Invalid date format: " + dateRange);
                        e.printStackTrace();
                    }
                }
                
                return cb.and(predicates.toArray(new Predicate[0]));
            }, pageable);
            
        } catch (Exception e) {
            e.printStackTrace();
            // Return empty page in case of error
            return Page.empty(pageable);
        }
    }

    // -------- HELPER METHOD TO GET ORDER BY ID --------
    public OrderDtls getOrderById(Integer id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found with ID: " + id));
    }
    
    // -------- BULK STATUS UPDATE --------
    public void bulkUpdateStatus(List<Integer> orderIds, String status) {
        for (Integer orderId : orderIds) {
            updateOrderStatus(orderId, status, null);
        }
    }
}