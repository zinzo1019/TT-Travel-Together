package com.example.choyoujin.websocket;

import lombok.Builder;
import lombok.Data;
import org.springframework.web.socket.WebSocketSession;

import java.util.HashSet;
import java.util.Set;

@Data
@Builder
public class ChatRoom {
    private String roomId; // 채팅방 아이디
    private String name; // 채팅방 이름
    private Integer postId; // 게시글 아이디
    private Set<WebSocketSession> sessions = new HashSet<>();
}