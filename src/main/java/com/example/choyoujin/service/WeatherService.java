package com.example.choyoujin.service;
import com.example.choyoujin.dto.WeatherData;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class WeatherService {
    @Value("${weather_api_key}")
    private String apiKey;
    private final String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s";
    private final RestTemplate restTemplate;

    public WeatherService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public WeatherData getWeatherByCity(String city) {
        String url = String.format(apiUrl, city, apiKey);
        WeatherData weatherData = restTemplate.getForObject(url, WeatherData.class);
        System.out.println(weatherData.toString());
        return weatherData;
    }
}
