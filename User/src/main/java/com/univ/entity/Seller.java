
	package com.univ.entity;

	import jakarta.persistence.*;
	import java.time.LocalDateTime;

	@Entity
	@Table(name = "sellers")
	public class Seller {

	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long id;

	    // Personal Information
	    private String name;

	    private String mobileNumber;

	    @Column(unique = true, nullable = false)
	    private String email;

	    private String password;

	    // Business Information
	    private String businessName;

	    private String gstNumber;

	    private String address;

	    private String city;

	    private String state;

	    private String pincode;

	    // Bank Details
	    private String bankName;

	    private String accountNumber;

	    private String accountHolderName;

	    private String ifscCode;

	    // Profile Image (store as file path or URL)
	    private String img;

	    // Seller Status (Admin ke approval ke baad update hoga)
	    private String status = "Pending"; // Default: Pending
	    @Column(columnDefinition = "datetime")
	    private LocalDateTime registrationDate = LocalDateTime.now();

	    // ===== Getters and Setters =====
	    public Long getId() {
	        return id;
	    }

	    public void setId(Long id) {
	        this.id = id;
	    }

	    public String getName() {
	        return name;
	    }

	    public void setName(String name) {
	        this.name = name;
	    }

	    public String getMobileNumber() {
	        return mobileNumber;
	    }

	    public void setMobileNumber(String mobileNumber) {
	        this.mobileNumber = mobileNumber;
	    }

	    public String getEmail() {
	        return email;
	    }

	    public void setEmail(String email) {
	        this.email = email;
	    }

	    public String getPassword() {
	        return password;
	    }

	    public void setPassword(String password) {
	        this.password = password;
	    }

	    public String getBusinessName() {
	        return businessName;
	    }

	    public void setBusinessName(String businessName) {
	        this.businessName = businessName;
	    }

	    public String getGstNumber() {
	        return gstNumber;
	    }

	    public void setGstNumber(String gstNumber) {
	        this.gstNumber = gstNumber;
	    }

	    public String getAddress() {
	        return address;
	    }

	    public void setAddress(String address) {
	        this.address = address;
	    }

	    public String getCity() {
	        return city;
	    }

	    public void setCity(String city) {
	        this.city = city;
	    }

	    public String getState() {
	        return state;
	    }

	    public void setState(String state) {
	        this.state = state;
	    }

	    public String getPincode() {
	        return pincode;
	    }

	    public void setPincode(String pincode) {
	        this.pincode = pincode;
	    }

	    public String getBankName() {
	        return bankName;
	    }

	    public void setBankName(String bankName) {
	        this.bankName = bankName;
	    }

	    public String getAccountNumber() {
	        return accountNumber;
	    }

	    public void setAccountNumber(String accountNumber) {
	        this.accountNumber = accountNumber;
	    }

	    public String getAccountHolderName() {
	        return accountHolderName;
	    }

	    public void setAccountHolderName(String accountHolderName) {
	        this.accountHolderName = accountHolderName;
	    }

	    public String getIfscCode() {
	        return ifscCode;
	    }

	    public void setIfscCode(String ifscCode) {
	        this.ifscCode = ifscCode;
	    }

	    public String getImg() {
	        return img;
	    }

	    public void setImg(String img) {
	        this.img = img;
	    }

	    public String getStatus() {
	        return status;
	    }

	    public void setStatus(String status) {
	        this.status = status;
	    }

	    public LocalDateTime getRegistrationDate() {
	        return registrationDate;
	    }

	    public void setRegistrationDate(LocalDateTime registrationDate) {
	        this.registrationDate = registrationDate;
	    }
	}



