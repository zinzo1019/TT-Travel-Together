<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%@ include file="../base_view/header.jsp" %>
<c:choose>
    <c:when test="${user.role eq 'ROLE_ADMIN'}">
        <%@ include file="/WEB-INF/views/admin/base_view/navigation.jsp" %>
    </c:when>
    <c:otherwise>
        <%@ include file="../base_view/navigation.jsp" %>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>

<style>
    .content {
        margin-left: 18%; /* 네비게이션 바의 넓이와 일치하도록 설정 */
        padding: 20px; /* 적절한 여백 */
        display: flex;
        justify-content: center; /* 가로 중앙 정렬 */
        margin-bottom: 5%;
        overflow-y: auto; /* 네비게이션 바 내용이 화면을 벗어날 경우 스크롤 바 추가 */
    }

    .main-container {
        width: 70%;
        padding: 20px; /* 내부 여백 추가 */
        margin-top: 16%;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    .background-container {
        background-color: #f0f0f0; /* 원하는 배경 색상으로 설정 */
        padding: 20px; /* 내부 여백 추가 */
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        margin-bottom: 3%;
    }

    /* 채팅 메시지를 감싸는 부모 컨테이너에 대한 스타일 */
    .chat-container {
        max-width: 600px; /* 최대 너비 설정 */
        margin: 20px auto; /* 가운데 정렬 */
    }

    /* 각 채팅 메시지에 대한 스타일 */
    .message-container {
        display: flex;
        align-items: flex-start;
        margin: 10px 0;
    }

    .message-bubble {
        max-width: 70%;
        padding: 10px;
        border-radius: 10px;
        background-color: #f9f9f9;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    /* 보낸 사람 이름에 대한 스타일 */
    .sender-name {
        font-size: 12px;
        font-weight: bold;
        color: #3366cc; /* 파란색 */
        margin-bottom: 4px;
    }

    /* 메시지 텍스트에 대한 스타일 */
    .message-text {
        font-size: 14px;
        margin: 0;
    }

    /* 입력창 스타일 */
    #messageInput {
        width: calc(100% - 20px);
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    /* 전송 버튼 스타일 */
    .sendBtn {
        width: 100%;
        padding: 10px;
        background-color: #4CAF50;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .sendBtn:hover {
        background-color: #45a049;
    }

    /* 나가기 버튼 스타일 */
    .quit {
        width: 100%;
        padding: 10px;
        background-color: #ff5555;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .quit:hover {
        background-color: #ff0000;
    }
</style>

<body>
<div class="content">
    <div class="main-container">
        <div class="msgArea">
            <c:forEach var="message" items="${messages}">
                <c:if test="${message.messageType == 'TALK'}">
                    <div class="message-container">
                        <div class="message-bubble">
                            <div class="sender-name">${message.senderName}</div>
                            <p class="message-text">${message.message}</p>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <input type="text" id="messageInput" placeholder="보낼 메세지를 입력하세요.">
        <button type="button" value="전송" class="sendBtn" onclick="sendMsg()">전송</button>
        <button type="button" value="방나가기" class="quit" onclick="quit()">방 나가기</button>
    </div>
</div>
</body>

<script>

    let roomId = '${room.roomid}';
    let username = '${user.name}';

    var socket = new WebSocket("ws://192.168.1.77:8081/ws/chat");

    socket.onopen = function (e) {
        console.log('WebSocket connection opened');
        enterRoom(socket);
    };

    socket.onclose = function (e) {
        console.log('disconnet');
        location.reload(); // 새로고침
    };

    socket.onerror = function (e) {
        console.log(e);
    };

    // 메세지 수신했을 때 이벤트
    socket.onmessage = function (e) {
        let messageDto = e.data;
        let splitMessageDto = messageDto.split('"');

        let username = splitMessageDto[splitMessageDto.indexOf('name') + 2]
        let message = splitMessageDto[splitMessageDto.indexOf('message') + 2]

        var msgArea = document.querySelector('.msgArea');
        var newMsg = document.createElement('div');
        newMsg.classList.add('message-container'); // 새로운 메시지 컨테이너에 클래스 추가

        var messageBubble = document.createElement('div');
        messageBubble.classList.add('message-bubble'); // 말풍선 스타일을 가진 컨테이너

        if (message == '') { // 메세지가 비어있다면
            messageBubble.innerHTML = '<div class="sender-name">' + username + '님이 입장했습니다.</div>';
        } else {
            messageBubble.innerHTML = '<div class="sender-name">' + username + '</div>' +
                '<p class="message-text">' + message + '</p>';
        }

        newMsg.appendChild(messageBubble);
        msgArea.appendChild(newMsg);
        msgArea.append(newMsg);

        document.getElementById('messageInput').value = ''; // 메세지 전송 후 메세지 칸 비우기

        $.ajax({
            type: 'post',
            url: '/user/chat/save_chat',
            data: {
                chatRoomId: roomId, // 채팅방 번호
                sender: '${user.name}', // 사용자 이름
                senderId: ${user.userId}, // 사용자 아이디
                message: message, // 메세지
            },
        })
    };

    function enterRoom(socket) {
        var enterMsg = {"messageType": "ENTER", "chatRoomId": roomId, "name": username, "message": ""};
        socket.send(JSON.stringify(enterMsg));
    }

    // 메세지 보내기 버튼 눌렀을 때
    function sendMsg() {
        var content = document.getElementById('messageInput').value;
        console.log(content)

        if (content == '') return; // 메세지가 없을 시 전송 X
        var talkMsg = {"messageType": "TALK", "chatRoomId": roomId, "name": username, "message": content};
        socket.send(JSON.stringify(talkMsg));
    }

    function quit() {
        var quitMsg = {"messageType": "QUIT", "chatRoomId": roomId, "name": username, "message": ""};
        socket.send(JSON.stringify(quitMsg));
        // socket.close();
        history.back();
    }
</script>
</html>