package com.example.choyoujin.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * 소켓 통신은 서버와 클라이언트가 1:n 관계를 맺는다.
 * 따라서 한 서버에 여러 클라이언트 접속 가능
 * 서버에서는 여러 클라이언트가 발송한 메세지를 받아 처리해줄 핸들러가 필요
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class WebSocketChatHandler implements WebSocketHandler {

    private final ObjectMapper mapper;
    private final Set<WebSocketSession> sessions = new HashSet<>(); // 현재 연결된 세션들
    private final Map<String,Set<WebSocketSession>> chatRoomSessionMap = new HashMap<>(); // 채팅방 당 연결된 세션을 담음

    // 소켓 연결 성공
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("{} 연결됨", session.getId());
        sessions.add(session);
    }

    // 소켓 통신 시 메세지 전송을 다루는 부분
    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        String payload = (String) message.getPayload();
        log.info("payload {}", payload);

        // 페이로드 -> chatMessageDto 변환
        ChatMessageDto chatMessageDto = mapper.readValue(payload, ChatMessageDto.class);

        // room의 아이디
        String chatRoomId = chatMessageDto.getChatRoomId();

        // 메모리 상에 채팅방에 대한 세션이 없으면 만들어줌
        if (!chatRoomSessionMap.containsKey(chatRoomId)) {
            // room을 sessionMap에 추가
            chatRoomSessionMap.put(chatRoomId, new HashSet<>());
        }

        // room과 연결된 모든 세션 가져오기
        Set<WebSocketSession> chatRoomSession = chatRoomSessionMap.get(chatRoomId);

        if (chatMessageDto.getMessageType().equals("ENTER")) { // 메세지에 담긴 타입 확인
            chatRoomSession.add(session); // room에 세션 추가
        }

        if (chatRoomSession.size() >= 3) {
            removeClosedSession(chatRoomSession);
        }

        sendMessageToChatRoom(chatMessageDto, chatRoomSession); // 채팅방 내부 세션들에게 메세지 전송
    }

    // 연결이 끊어진 세션 삭제
    private void removeClosedSession(Set<WebSocketSession> chatRoomSession) {
        chatRoomSession.removeIf(sess -> !sessions.contains(sess));
    }

    // 세션에게 메세지 전송
    private void sendMessageToChatRoom(ChatMessageDto chatMessageDto, Set<WebSocketSession> chatRoomSession) {
        chatRoomSession.parallelStream().forEach(sess -> sendMessage(sess, chatMessageDto));
    }

    public <T> void sendMessage(WebSocketSession session, T message) {
        try {
            session.sendMessage(new TextMessage(mapper.writeValueAsBytes(message)));
        } catch (IOException e) {
             log.error(e.getMessage(), e);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        log.info("{} 연결 끊김", session.getId());
        sessions.remove(session);
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {

    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }
}
