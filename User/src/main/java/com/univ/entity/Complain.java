package com.univ.entity;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "complain")
public class Complain {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserDtls user;

    @Column(name = "order_id", nullable = true)
    private Integer orderId;

    @Column(name = "complaint_date", nullable = false)
    private LocalDateTime complaintDate;

    @Column(nullable = false, length = 255)
    private String subject;

    @Column(nullable = false, length = 1000)
    private String message;

    @Column(nullable = false, length = 50)
    private String status;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "resolved_date")
    private LocalDateTime resolvedDate;

    @Lob
    @Column(name = "attachment", columnDefinition = "LONGBLOB")
    private byte[] attachment;

    @Column(name = "attachment_name", length = 255)
    private String attachmentName;

    @Column(name = "attachment_type", length = 100)
    private String attachmentType;

    // Constructor
    public Complain() {
        this.createdAt = LocalDateTime.now();
        this.complaintDate = LocalDateTime.now();
        this.status = "PENDING";
    }

    // Getter & Setter
    public Integer getId() {
        return id;
    }

    public UserDtls getUser() {
        return user;
    }

    public void setUser(UserDtls user) {
        this.user = user;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public LocalDateTime getComplaintDate() {
        return complaintDate;
    }

    public void setComplaintDate(LocalDateTime complaintDate) {
        this.complaintDate = complaintDate;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getResolvedDate() {
        return resolvedDate;
    }

    public void setResolvedDate(LocalDateTime resolvedDate) {
        this.resolvedDate = resolvedDate;
    }

    public byte[] getAttachment() {
        return attachment;
    }

    public void setAttachment(byte[] attachment) {
        this.attachment = attachment;
    }

    public String getAttachmentName() {
        return attachmentName;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    public String getAttachmentType() {
        return attachmentType;
    }

    public void setAttachmentType(String attachmentType) {
        this.attachmentType = attachmentType;
    }

    // ✅ ToString for debugging
    @Override
    public String toString() {
        return "Complain{" +
                "id=" + id +
                ", user=" + (user != null ? user.getId() + ":" + user.getName() : "null") +
                ", orderId=" + orderId +
                ", complaintDate=" + complaintDate +
                ", subject='" + subject + '\'' +
                ", message='" + message + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                ", resolvedDate=" + resolvedDate +
                ", attachmentName='" + attachmentName + '\'' +
                ", attachmentType='" + attachmentType + '\'' +
                '}';
    }
}
