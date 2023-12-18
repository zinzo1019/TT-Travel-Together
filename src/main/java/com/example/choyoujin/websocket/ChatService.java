package com.example.choyoujin.websocket;

import com.example.choyoujin.dao.ChatDao;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.*;

@Slf4j
@Data
@Service
public class ChatService {

    @Autowired
    private ChatDao chatDao;

    private final ObjectMapper mapper;
    private Map<String, ChatRoom> chatRooms;

    @PostConstruct
    private void init() {
        chatRooms = new LinkedHashMap<>();
    }

    /** 모든 채팅방 리스트 가져오기 */
    public List<ChatRoom> findAllRoom(){
        System.out.println("현재 모든 채팅방: " + chatRooms.values());
        return new ArrayList<>(chatRooms.values());
    }

    public ChatRoom findRoomById(String roomId){
        return chatRooms.get(roomId);
    }

    public ChatRoom findRoomByName(String name){
        return chatRooms.get(name);
    }

    // 채팅방 생성
    public ChatRoom createRoom(ChatRoom chatRoom) {

        // 채팅방 저장하기
        chatDao.saveChatRoom();

        String roomId = UUID.randomUUID().toString(); // 랜덤한 방 아이디 생성
        ChatRoom room = ChatRoom.builder()
                .roomId(roomId)
                .name(chatRoom.getName())
                .postId(chatRoom.getPostId())
                .build();

        chatRooms.put(roomId, room); // 랜덤 아이디와 room 정보를 Map 에 저장

        System.out.println("채팅방 이름 => " + chatRoom.getName());
        System.out.println("채팅방 리스트 => " + chatRooms);

        return room;
    }

    public <T> void sendMessage(WebSocketSession session, T message) {
        try{
            session.sendMessage(new TextMessage(mapper.writeValueAsString(message)));
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }
    }
}