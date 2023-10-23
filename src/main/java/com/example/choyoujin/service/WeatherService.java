package com.example.choyoujin.service;
import com.example.choyoujin.dto.WeatherData;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class WeatherService {
    private final String apiKey = "5cbae45a5010927180e0679226e34382"; // key
    private final String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s";

    private final RestTemplate restTemplate;

    public WeatherService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public WeatherData getWeatherByCity(String city) {
        String url = String.format(apiUrl, city, apiKey);
        return restTemplate.getForObject(url, WeatherData.class);
    }
}
