package com.emse.bicycleSharingStations.controller;

import com.emse.bicycleSharingStations.model.BicycleStation;
import com.emse.bicycleSharingStations.service.BicycleStationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class BicycleStationController {
    // inject via application.properties
//    @Value("${welcome.message:test}")
//    private String message = "Hello World";

    @Autowired
    BicycleStationService bicycleStationService;

    @RequestMapping("/")
    public String welcome(Map<String, Object> model) {
//        model.put("message", this.message);
        return "bicycle";
    }

    @RequestMapping("/extractStatic")
    public String extractStatic(Map<String, Object> model) {
        return "extractStatic";
    }

    @RequestMapping("/hello")
    public String hello(Map<String, Object> model) {
//        model.put("message", this.message);
        return "bicycle";
    }



}