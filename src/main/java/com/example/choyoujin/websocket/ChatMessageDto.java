package com.example.choyoujin.websocket;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

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
    private String messageType; // 메시지 타입
    private String chatRoomId; // 방 번호
    private String name; // 방 이름
    private String sender; // 채팅을 보낸 사람
    private Long senderId; // 채팅을 보낸 사람
    private String message; // 메시지
    private LocalDateTime createTime; // 메세지 송신 시간

    @JsonCreator
    public ChatMessageDto(@JsonProperty("messageType") String messageType,
                          @JsonProperty("chatRoomId") String chatRoomId,
                          @JsonProperty("name") String name,
                          @JsonProperty("sender") String sender,
                          @JsonProperty("senderId") Long senderId,
                          @JsonProperty("message") String message,
                          @JsonProperty("createTime") LocalDateTime createTime) {
        this.messageType = messageType;
        this.chatRoomId = chatRoomId;
        this.name = name;
        this.sender = sender;
        this.senderId = senderId;
        this.message = message;
        this.createTime = createTime;
    }
}