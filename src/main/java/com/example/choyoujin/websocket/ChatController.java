package com.example.choyoujin.websocket;

import com.example.choyoujin.dto.UserDto;
import com.example.choyoujin.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/user/chat")
public class ChatController {

    private final ChatService chatService;
    private final UserService userService;

    /** 채팅방 생성 */
    @PostMapping("/createRoom")
    public String createRoom(ChatRoom chatRoom, Model model) {
        ChatRoom room = chatService.createRoom(chatRoom);
        model.addAttribute("room",room);
        return "chat/chatRoom";
    }

    /** 모든 채팅방 리스트 가져오기 */
    @RequestMapping("/chatList")
    public String chatList(Model model){
        List<ChatRoom> roomList = chatService.findAllRoom();
        model.addAttribute("roomList",roomList);
        return "chat/chatList";
    }

    /** 채팅방 입장하기 */
    @GetMapping("/chatRoom/{roomId}")
    public String chatRoom(Model model,  @PathVariable("roomId") String roomId){
        ChatRoom room = chatService.findRoomById(roomId);
        model.addAttribute("room",room);

        UserDto userDto = userService.getUserData();
        model.addAttribute("userDto", userDto);
        return "chat/chatRoom";
    }
}