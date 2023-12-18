package com.example.choyoujin.websocket;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

/**
 * {
 * "messageType":"TALK", // ENTER, TALK
 * "chatRoomId":1, // 채팅방 번호
 * "senderId":100, // 메세지 전송자의 UserId
 * "message":"hello" // 메세지 내용
 * }
 */

@Data
@Builder
public class ChatMessageDto {
    private MessageType messageType; // 메시지 타입
    private String chatRoomId; // 방 번호
    private String name; // 방 이름
    private Long senderId; // 채팅을 보낸 사람
    private String message; // 메시지

    @JsonCreator
    public ChatMessageDto(@JsonProperty("messageType") MessageType messageType,
                          @JsonProperty("chatRoomId") String chatRoomId,
                          @JsonProperty("name") String name,
                          @JsonProperty("senderId") Long senderId,
                          @JsonProperty("message") String message) {
        this.messageType = messageType;
        this.chatRoomId = chatRoomId;
        this.name = name;
        this.senderId = senderId;
        this.message = message;
    }
}