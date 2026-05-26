package com.univ.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;

@Entity
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 500)
    private String title;

    @Lob
    @Column(columnDefinition = "TEXT")
    private String description;

    private String category;

    private Double price;

    // ✅ BEST STOCK DESIGN
    private Double stockQty;      // 10, 5, 2.5
    private String stockUnit;     // kg / liter / quintal

    private String image;

    private int discount;

    private Double discountPrice;

    private Boolean isActive;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    // ================== GETTERS & SETTERS ==================

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getStockQty() {
        return stockQty;
    }

    public void setStockQty(Double stockQty) {
        this.stockQty = stockQty;
    }

    public String getStockUnit() {
        return stockUnit;
    }

    public void setStockUnit(String stockUnit) {
        this.stockUnit = stockUnit;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public Double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(Double discountPrice) {
        this.discountPrice = discountPrice;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
    public Product getProduct() {
        return product;  // ✔ सही
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    // ================== OPTIONAL HELPER METHODS ==================

    // Display stock like: "10 kg"
    public String getStockDisplay() {
        if (stockQty == null || stockUnit == null) {
            return "";
        }
        return stockQty + " " + stockUnit;
    }

    // Alias (agar kahin name chahiye ho)
    public String getName() {
        return title;
    }
}
