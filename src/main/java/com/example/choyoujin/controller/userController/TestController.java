package com.example.choyoujin.controller.userController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.net.HttpURLConnection;
import java.net.URL;
import java.io.BufferedReader;
import java.io.InputStreamReader;

import com.google.maps.*;
import com.google.maps.model.*;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {

    String apiKey = "AIzaSyCBjBB-HmcBRGNjJjXd3UUndRnsaoyk0gg"; // Google Maps API Key

    /** 구글맵 API 테스트 */
    @GetMapping("/google/maps/test")
    @ResponseBody
    public String googleMapsTest(@RequestParam("query") String query) {
        String placeId = searchPlace(query);
        try {
            String url = "https://maps.googleapis.com/maps/api/place/details/json" +
                    "?place_id=" + placeId +
                    "&fields=address_components" +
                    "&key=" + apiKey;

            // HTTP GET 요청 보내기
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("GET");

            // 응답 읽기
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // 응답 출력
            System.out.println(response);
            return response.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "장소를 찾지 못했습니다.";
    }

    /** 장소 이름으로 placeId 받아오기 */
    public String searchPlace(String query) {
        GeoApiContext context = new GeoApiContext.Builder().apiKey(apiKey).build();
        try {
            PlacesSearchResponse response = PlacesApi.textSearchQuery(context, query).await();
            if (response != null && response.results.length > 0) {
                System.out.println("Place ID: " + response.results[0].placeId);
                return response.results[0].placeId; // placeId 키 리턴
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 에러 시 null 리턴
    }
}

