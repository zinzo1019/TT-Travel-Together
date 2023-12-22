package com.example.choyoujin.websocket;

public enum MessageType {
    ENTER("ENTER"),
    TALK("TALK"),
    QUIT("QUIT");

    private String messageType;

    MessageType(String messageType) {
        this.messageType = messageType;
    }

    public String getMessageType() {
        return messageType;
    }
}
