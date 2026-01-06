package com.av.razorhealth.api.controller;

import com.av.razorhealth.api.model.Client;
import com.av.razorhealth.api.repository.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "Razor Health API is up and running!";
    }
}
