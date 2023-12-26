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
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/user/chat")
public class ChatController {

    private final ChatService chatService;
    private final UserService userService;

//    /** 채팅방 생성 */
//    @PostMapping("/createRoom")
//    public String createRoom(ChatRoom chatRoom, Model model) {
//        ChatRoom room = chatService.createRoom(chatRoom);
//        model.addAttribute("room",room);
//        return "chat/chatRoom";
//    }
//
//    /** 채팅방 입장하기 */
//    @PostMapping("/enterRoom")
//    public String enterRoom(ChatRoom chatRoom, Model model) {
//        ChatRoom room = chatService.createRoom(chatRoom);
//        model.addAttribute("room",room);
//        return "chat/chatRoom";
//    }

    /** 모든 채팅방 리스트 가져오기 */
    @RequestMapping("/chatList")
    public String chatList(Model model){
        List<Map<String, Object>> roomList = chatService.findAllRoom();
        model.addAttribute("roomList",roomList);
        return "chat/chatList";
    }

    /** 채팅방 입장하기 */
    @GetMapping("/chatRoom/{roomId}")
    public String chatRoom(Model model,  @PathVariable("roomId") String roomId){
        // 채팅방 입장 자격 검사
        if (!chatService.checkQualification(roomId))  { // 자격이 없다면
            String postId = roomId.split("_")[3];
            return "redirect:/user/community/together/view?postId=" + postId + "&error=NQ";
        }

        model.addAttribute("user", userService.getUserData()); // 사용자 정보 담기
        model.addAttribute("room",chatService.findRoomById(roomId)); // 채팅방 정보 담기
        model.addAttribute("messages", chatService.findAllChatByRoomId(roomId)); // 메세지 정보 담기
        return "chat/chatRoom";
    }

    @PostMapping("/save_chat")
    public void saveChat(ChatMessageDto chatMessageDto) {
        System.out.println("송신 메세지 => " + chatMessageDto);
        chatService.saveChatMessage(chatMessageDto);
    }
}