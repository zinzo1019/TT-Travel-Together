package com.example.choyoujin.dto;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true) // 알 수 없는 속성 무시
@Data
public class WeatherData {
    private String name; // 도시 이름
    private Main main; // 날씨 정보 (온도, 습도, 압력 등)
    private List<Weather> weather; // 날씨 상태 정보
    private Wind wind; // 바람 정보

    @Data
    public static class Main {
        private double temp; // 온도
        private int humidity; // 습도
        private double pressure; // 대기압
        private double temp_min; // 최저 온도
        private double temp_max; // 최고 온도
    }

    @Data
    public static class Weather {
        private String main; // 날씨 상태 (맑음, 흐림 등)
        private String description; // 날씨 상태 설명
    }

    @Data
    public static class Wind {
        private double speed; // 바람 속도
        private int deg; // 바람 풍향 (각도)
    }
}


