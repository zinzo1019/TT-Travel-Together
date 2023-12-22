package com.example.choyoujin.websocket;

import com.example.choyoujin.dao.ChatDao;
import com.example.choyoujin.dto.UserDto;
import com.example.choyoujin.service.TravelTogetherService;
import com.example.choyoujin.service.UserService;
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
    @Autowired
    private UserService userService;
    @Autowired
    private TravelTogetherService togetherService;

    private final ObjectMapper mapper;
    private Map<String, ChatRoom> chatRooms;

    @PostConstruct
    private void init() {
        chatRooms = new LinkedHashMap<>();
    }

    /**
     * 모든 채팅방 리스트 가져오기
     */
    public List<Map<String, Object>> findAllRoom(){
        return chatDao.findAllChatRoom();
    }

    /** 채팅방 아이디로 채팅방 정보 가져오기 */
    public Map<String, Object> findRoomById(String roomId){
        return chatDao.findRoomByRoomId(roomId);
    }

    public ChatRoom findRoomByName(String name){
        return chatRooms.get(name);
    }

    /** 채팅방 생성하기 */
    public ChatRoom createRoom(ChatRoom chatRoom) {
        chatDao.saveChatRoom(chatRoom); // 채팅방 저장하기
        chatRooms.put(chatRoom.getRoomId(), chatRoom);

        System.out.println("채팅방 이름 => " + chatRoom.getRoomId());
        System.out.println("채팅방 리스트 => " + chatRooms);
        return chatRoom;
    }

    public <T> void sendMessage(WebSocketSession session, T message) {
        try{
            session.sendMessage(new TextMessage(mapper.writeValueAsString(message)));
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }
    }

    /** 채팅 메세지 저장하기 */
    public void saveChatMessage(ChatMessageDto chatMessageDto) {
        if (chatMessageDto.getMessage() == "") {
            chatMessageDto.setMessageType("ENTER");
            chatMessageDto.setMessage(chatMessageDto.getSender() + "님이 입장했습니다.");
        } else {
            chatMessageDto.setMessageType("TALK");
        }
        chatDao.saveChatMessage(chatMessageDto);
    }

    /**
     * 채팅 내역 가져오기
     */
    public List<Map<String, Object>> findAllChatByRoomId(String roomId) {
        try {
            return chatDao.findAllChatByRoomId(roomId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    /** 채팅방 입장 자격 검사 */
    public boolean checkQualification(String roomId) {
        int postId = Integer.valueOf(roomId.split("_")[3]); // roomId -> postId 추출
        List<UserDto> recruitedMember = togetherService.findRecruitedMember(postId); // 모집된 회원 조회
        for (UserDto user : recruitedMember) { // 로그인 한 사용자가 모집된 인원에 포함돼 있는지 확인
            if (user.getUserId() == userService.getUserData().getUserId()) {
                return true; // 모집된 인원 O
            }
        }
        return false; // 모집된 인원 X
    }

    /** 채팅 내역 삭제하기 */
    public void deleteChatMessagesByCRoomId(String roomId) {
        chatDao.deleteChatMessagesByCRoomId(roomId);
    }

    /** 채팅방 삭제하기 */
    public void deleteChatRoom(String roomId) {
        chatDao.deleteChatRoom(roomId);
    }
}