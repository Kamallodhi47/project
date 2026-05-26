package com.univ.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "cart_items")
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;  

    private Integer userId;       
    private Integer productId;    
    private String productName;   
    private Double price;         
    private Integer quantity;     
    private String productImage;

    @Transient
    private Double totalPrice;

    public Cart() {}

    public Cart(Integer userId, Integer productId, String productName, 
                Double price, Integer quantity, String productImage) {
        this.userId = userId;
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.productImage = productImage;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }

    public Double getTotalPrice() {
        if (price != null && quantity != null) {
            return price * quantity;
        }
        return 0.0;
    }

    public boolean isEmpty() {
        return quantity == null || quantity <= 0;
    }

    @Override
    public String toString() {
        return "Cart [id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", productName=" + productName +
                ", price=" + price +
                ", quantity=" + quantity +
                ", productImage=" + productImage +
                ", totalPrice=" + getTotalPrice() +
                "]";
    }
}