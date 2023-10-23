package com.example.choyoujin.controller.userController;

import com.example.choyoujin.dto.WeatherData;
import com.example.choyoujin.service.WeatherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/weather")
public class WeatherController {
    private final WeatherService weatherService;

    @Autowired
    public WeatherController(WeatherService weatherService) {
        this.weatherService = weatherService;
    }

    // http://localhost:8080/weather/seoul&units=metric
    @GetMapping("/{city}")
    public WeatherData getWeatherByCity(@PathVariable String city) {
        return weatherService.getWeatherByCity(city);
    }
}