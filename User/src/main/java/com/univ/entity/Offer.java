package com.univ.entity;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;

@Entity
public class Offer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String title;

    @Enumerated
    private OfferType offerType;

    private String description;

    private Integer priority = 0;

    private Double minCartValue;

    private Integer maxUsagePerUser = 1;

    private Integer totalUsageLimit;

    private Boolean active = true;

    private LocalDateTime startDate;
    private LocalDateTime endDate;

    private String bannerImage;

    private Integer discountPercentage;

    @ManyToMany(fetch = FetchType.LAZY)
    private List<Product> eligibleProducts;

    @ManyToMany(fetch = FetchType.LAZY)
    private List<Product> freeProducts;

    @OneToMany(mappedBy = "offer", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OfferUsage> offerUsages = new ArrayList<>();
    // Getters and Setters...
    //@Transient
    private Boolean applied = false;

    public Boolean getApplied() {
        return applied;
    }

    public void setApplied(Boolean applied) {
        this.applied = applied;
    }
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public OfferType getOfferType() { return offerType; }
    public void setOfferType(OfferType offerType) { this.offerType = offerType; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Integer getPriority() { return priority; }
    public void setPriority(Integer priority) { this.priority = priority; }

    public Double getMinCartValue() { return minCartValue; }
    public void setMinCartValue(Double minCartValue) { this.minCartValue = minCartValue; }

    public Integer getMaxUsagePerUser() { return maxUsagePerUser; }
    public void setMaxUsagePerUser(Integer maxUsagePerUser) { this.maxUsagePerUser = maxUsagePerUser; }

    public Integer getTotalUsageLimit() { return totalUsageLimit; }
    public void setTotalUsageLimit(Integer totalUsageLimit) { this.totalUsageLimit = totalUsageLimit; }

    public Boolean getActive() { return active; }
    public void setActive(Boolean active) { this.active = active; }

    public LocalDateTime getStartDate() { return startDate; }
    public void setStartDate(LocalDateTime startDate) { this.startDate = startDate; }

    public LocalDateTime getEndDate() { return endDate; }
    public void setEndDate(LocalDateTime endDate) { this.endDate = endDate; }

    public String getBannerImage() { return bannerImage; }
    public void setBannerImage(String bannerImage) { this.bannerImage = bannerImage; }

    public Integer getDiscountPercentage() { return discountPercentage; }
    public void setDiscountPercentage(Integer discountPercentage) { this.discountPercentage = discountPercentage; }

    public List<Product> getEligibleProducts() { return eligibleProducts; }
    public void setEligibleProducts(List<Product> eligibleProducts) { this.eligibleProducts = eligibleProducts; }

    public List<Product> getFreeProducts() { return freeProducts; }
    public void setFreeProducts(List<Product> freeProducts) { this.freeProducts = freeProducts; }
	
    private Double flatDiscount;
    private Integer buyQty;
    private Integer getQty;
    private Integer totalUsed = 0;
    public Double getFlatDiscount() {
        return flatDiscount;
    }

    public void setFlatDiscount(Double flatDiscount) {
        this.flatDiscount = flatDiscount;
    }

    public Integer getBuyQty() {
        return buyQty;
    }

    public void setBuyQty(Integer buyQty) {
        this.buyQty = buyQty;
    }

    public Integer getGetQty() {
        return getQty;
    }

    public void setGetQty(Integer getQty) {
        this.getQty = getQty;
    }

    public Integer getTotalUsed() {
        return totalUsed;
    }

    public void setTotalUsed(Integer totalUsed) {
        this.totalUsed = totalUsed;
    }
}