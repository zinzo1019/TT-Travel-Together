package com.example.choyoujin.dao;

import com.example.choyoujin.websocket.ChatMessageDto;
import com.example.choyoujin.websocket.ChatRoom;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ChatDao {
    void saveChatRoom(ChatRoom chatRoom);
    List<Map<String, Object>> findAllChatRoom();
    Map<String, Object> findRoomByRoomId(String roomId);
    void saveChatMessage(ChatMessageDto chatMessageDto);
    List<Map<String, Object>> findAllChatByRoomId(String roomId);
    void deleteChatMessagesByCRoomId(String roomId);
    void deleteChatRoom(String roomId);
}
