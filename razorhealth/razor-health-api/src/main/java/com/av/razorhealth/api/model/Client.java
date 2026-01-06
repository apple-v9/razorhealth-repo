package com.av.razorhealth.api.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "rz_clients")
public class Client {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "client_id")
    private Integer clientId;

    @Column(name = "client_name", nullable = false, length = 100)
    private String clientName;

    @Column(name = "client_address", nullable = false, length = 255)
    private String clientAddress;

    @Column(name = "client_area", nullable = false, length = 255)
    private String clientArea;

    @Enumerated(EnumType.STRING)
    @Column(name = "client_importance", nullable = false)
    private ClientImportance clientImportance;

    @Enumerated(EnumType.STRING)
    @Column(name = "client_gender", nullable = false)
    private Gender clientGender;

    @Column(name = "client_has_pet", nullable = false)
    private Boolean clientHasPet = false;

    @Column(name = "rz_created_at", updatable = false)
    private LocalDateTime rzCreatedAt;

    @Column(name = "rz_last_updated_at")
    private LocalDateTime rzLastUpdatedAt;

    // Lifecycle callbacks
    @PrePersist
    protected void onCreate() {
        rzCreatedAt = LocalDateTime.now();
        rzLastUpdatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        rzLastUpdatedAt = LocalDateTime.now();
    }

    // Constructors
    public Client() {}

    public Client(String clientName, String clientAddress, String clientArea,
                  ClientImportance clientImportance, Gender clientGender, Boolean clientHasPet) {
        this.clientName = clientName;
        this.clientAddress = clientAddress;
        this.clientArea = clientArea;
        this.clientImportance = clientImportance;
        this.clientGender = clientGender;
        this.clientHasPet = clientHasPet;
    }

    // Getters and Setters
    public Integer getClientId() {
        return clientId;
    }

    public void setClientId(Integer clientId) {
        this.clientId = clientId;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public String getClientAddress() {
        return clientAddress;
    }

    public void setClientAddress(String clientAddress) {
        this.clientAddress = clientAddress;
    }

    public String getClientArea() {
        return clientArea;
    }

    public void setClientArea(String clientArea) {
        this.clientArea = clientArea;
    }

    public ClientImportance getClientImportance() {
        return clientImportance;
    }

    public void setClientImportance(ClientImportance clientImportance) {
        this.clientImportance = clientImportance;
    }

    public Gender getClientGender() {
        return clientGender;
    }

    public void setClientGender(Gender clientGender) {
        this.clientGender = clientGender;
    }

    public Boolean getClientHasPet() {
        return clientHasPet;
    }

    public void setClientHasPet(Boolean clientHasPet) {
        this.clientHasPet = clientHasPet;
    }

    public LocalDateTime getRzCreatedAt() {
        return rzCreatedAt;
    }

    public LocalDateTime getRzLastUpdatedAt() {
        return rzLastUpdatedAt;
    }

    @Override
    public String toString() {
        return "Client{" +
                "clientId=" + clientId +
                ", clientName='" + clientName + '\'' +
                ", clientArea='" + clientArea + '\'' +
                ", clientImportance=" + clientImportance +
                ", clientGender=" + clientGender +
                ", clientHasPet=" + clientHasPet +
                '}';
    }
}