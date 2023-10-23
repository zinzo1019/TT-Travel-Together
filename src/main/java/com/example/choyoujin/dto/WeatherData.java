package com.example.choyoujin.dto;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@JsonIgnoreProperties(ignoreUnknown = true) // 알 수 없는 속성 무시
@Data
public class WeatherData {
    private String name; // 도시 이름
    private double temp; // 온도 (예: 25.0)
    private int humidity; // 습도 (예: 65)
    private double pressure; // 기압 (예: 1012.5)
}
