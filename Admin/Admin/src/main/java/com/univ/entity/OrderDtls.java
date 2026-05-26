package com.univ.entity;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "order_dtls")
public class OrderDtls {

    // -------- PRIMARY KEY --------
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // -------- BASIC ORDER INFO --------
    @Column(nullable = false, unique = true)
    private String orderId;

    private String paymentId;

    private Double amount;
    private Double grandTotal;

    private String userName;

    @Column(nullable = false)
    private String status;

    // -------- ORDER STATUS DATES --------
    @Column(nullable = false)
    private LocalDateTime orderDate;

    private LocalDateTime confirmedDate;
    private LocalDateTime shippedDate;  // ✅ MOVED TO PROPER PLACE
    private LocalDateTime deliveredDate;
    private LocalDateTime cancelledDate;

    private String cancellationReason;

    // -------- REVIEW --------
    private Integer rating;
    
    @Column(length = 1000)
    private String review;

    // -------- ADDRESS INFO --------
    @Column(length = 500)
    private String shippingAddress;
    
    private String shippingCity;
    private String shippingState;
    private String shippingPincode;
    
    private String shippingMethod;
    private Double shippingCharge;

    // -------- USER RELATION --------
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id")
    private UserDtls user;

    // -------- ORDER ITEMS --------
    @OneToMany(
        mappedBy = "order",
        cascade = CascadeType.ALL,
        orphanRemoval = true,
        fetch = FetchType.LAZY
    )
    private List<OrderItem> items = new ArrayList<>();

    // -------- DEFAULT CONSTRUCTOR --------
    public OrderDtls() {}

    // -------- AUTO VALUES BEFORE INSERT --------
    @PrePersist
    public void prePersist() {
        if (this.orderDate == null) {
            this.orderDate = LocalDateTime.now();
        }
        if (this.status == null) {
            this.status = "PENDING";
        }
        if (this.orderId == null) {
            // Generate order ID if not provided
            this.orderId = "ORD" + System.currentTimeMillis();
        }
    }

    // -------- GETTERS & SETTERS --------
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public Double getAmount() {
        return amount != null ? amount : 0.0;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getGrandTotal() {
        return grandTotal != null ? grandTotal : (amount != null ? amount : 0.0);
    }

    public void setGrandTotal(Double grandTotal) {
        this.grandTotal = grandTotal;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public LocalDateTime getConfirmedDate() {
        return confirmedDate;
    }

    public void setConfirmedDate(LocalDateTime confirmedDate) {
        this.confirmedDate = confirmedDate;
    }

    public LocalDateTime getShippedDate() {
        return shippedDate;
    }

    public void setShippedDate(LocalDateTime shippedDate) {
        this.shippedDate = shippedDate;
    }

    public LocalDateTime getDeliveredDate() {
        return deliveredDate;
    }

    public void setDeliveredDate(LocalDateTime deliveredDate) {
        this.deliveredDate = deliveredDate;
    }

    public LocalDateTime getCancelledDate() {
        return cancelledDate;
    }

    public void setCancelledDate(LocalDateTime cancelledDate) {
        this.cancelledDate = cancelledDate;
    }

    public String getCancellationReason() {
        return cancellationReason;
    }

    public void setCancellationReason(String cancellationReason) {
        this.cancellationReason = cancellationReason;
    }

    public Integer getRating() {
        return rating != null ? rating : 0;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getShippingCity() {
        return shippingCity;
    }

    public void setShippingCity(String shippingCity) {
        this.shippingCity = shippingCity;
    }

    public String getShippingState() {
        return shippingState;
    }

    public void setShippingState(String shippingState) {
        this.shippingState = shippingState;
    }

    public String getShippingPincode() {
        return shippingPincode;
    }

    public void setShippingPincode(String shippingPincode) {
        this.shippingPincode = shippingPincode;
    }

    public String getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(String shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    public Double getShippingCharge() {
        return shippingCharge != null ? shippingCharge : 0.0;
    }

    public void setShippingCharge(Double shippingCharge) {
        this.shippingCharge = shippingCharge;
    }

    public UserDtls getUser() {
        return user;
    }

    public void setUser(UserDtls user) {
        this.user = user;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    // -------- HELPER METHODS --------
    public void addItem(OrderItem item) {
        this.items.add(item);
        item.setOrder(this);
    }

    public void removeItem(OrderItem item) {
        this.items.remove(item);
        item.setOrder(null);
    }

    // -------- BUSINESS METHODS --------
    public double calculateGrandTotal() {
        double total = 0.0;
        if (items != null) {
            total = items.stream()
                .mapToDouble(item -> item.getTotal() != null ? item.getTotal() : 0.0)
                .sum();
        }
        // Add shipping charge if applicable
        if (shippingCharge != null) {
            total += shippingCharge;
        }
        return total;
    }

    public boolean canBeCancelled() {
        return !"DELIVERED".equals(status) && !"CANCELLED".equals(status);
    }

    public boolean canBeShipped() {
        return "CONFIRMED".equals(status);
    }

    public boolean canBeDelivered() {
        return "SHIPPED".equals(status);
    }

    // -------- TO STRING --------
    @Override
    public String toString() {
        return "OrderDtls{" +
                "id=" + id +
                ", orderId='" + orderId + '\'' +
                ", status='" + status + '\'' +
                ", amount=" + amount +
                ", grandTotal=" + grandTotal +
                ", orderDate=" + orderDate +
                '}';
    }
}