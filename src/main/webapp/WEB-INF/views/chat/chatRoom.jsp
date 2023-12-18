<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<input type="text" placeholder="보낼 메세지를 입력하세요." class="content">
<button type="button" value="전송" class="sendBtn" onclick="sendMsg()">전송</button>
<button type="button" value="방나가기" class="quit" onclick="quit()">방 나가기</button>
<div>
    <span>메세지</span>
    <div class="msgArea"></div>
</div>
</body>

<script>

    let roomId = '${room.roomId}';
    let username = '${userDto.name}';

    console.log(username);

    function enterRoom(socket) {
        var enterMsg = {"messageType": "ENTER", "chatRoomId": roomId, "name": username, "message": ""};
        socket.send(JSON.stringify(enterMsg));
    }

    var socket = new WebSocket("ws://localhost:8081/ws/chat");

    socket.onopen = function (e) {
        console.log('open server');
        enterRoom(socket);
    };

    socket.onclose = function (e) {
        console.log('disconnet');
    };

    socket.onerror = function (e) {
        console.log(e);
    };

    // 메세지 수신했을 때 이벤트.
    socket.onmessage = function (e) {
        console.log(e.data);

        let messageDto = e.data;
        let splitMessageDto = messageDto.split('"');

        let username = splitMessageDto[11]
        let message = splitMessageDto[17]

        var msgArea = document.querySelector('.msgArea');
        var newMsg = document.createElement('div');

        if (message == '') { // 메세지가 비어있다면
            newMsg.innerText = username + '님이 입장했습니다.';
        } else {
            newMsg.innerText = username + ' | ' + message;
        }

        msgArea.append(newMsg);
    };

    // 메세지 보내기 버튼 눌렀을 때
    function sendMsg() {
        var content = document.querySelector('.content').value;
        var talkMsg = {"messageType": "TALK", "chatRoomId": roomId, "name": username, "message": content};
        socket.send(JSON.stringify(talkMsg));
    }

    function quit() {
        var quitMsg = {"messageType": "QUIT", "chatRoomId": roomId, "name": username, "message": ""};
        socket.send(JSON.stringify(quitMsg));
        socket.close();
        location.href = "/user/chat/chatList";
    }
</script>
</html>