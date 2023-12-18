package com.example.choyoujin.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
@Configuration
@EnableWebSocket
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer {

    // 웹소켓 핸들러 등록
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        // endpoint 설정 : /api/v1/chat/{postId}
        // 이를 통해서 ws://localhost:9090/ws/chat 으로 요청이 들어오면 websocket 통신을 진행한다.
        // setAllowedOrigins("*")는 모든 ip에서 접속 가능하도록 해줌

        String endPoint = "/ws/chat"; // 웹소켓 엔드포인트 지정 (ws://주소:포트/ws/chat)
        registry.addHandler(new WebSocketChatHandler(new ObjectMapper()), endPoint).setAllowedOrigins("*"); // 모든 cors 요청 허용
    }
}
