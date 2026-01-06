package com.av.razorhealth.api.repository;

import com.av.razorhealth.api.model.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClientRepository extends JpaRepository<Client, Integer> {
    // You can add custom queries here later
}
