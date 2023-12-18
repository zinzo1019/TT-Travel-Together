<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>

<form action="/user/chat/createRoom" method="post">
    <input type="text" name="name" placeholder="채팅방 이름">
    <button type="submit">방 만들기</button>
</form>

<table>
    <c:forEach var="room" items="${roomList}">
        <tr>
            <td>
                <a id="room_${room.roomId}" href="/user/chat/chatRoom/${room.roomId}" class="chatRoom" data-room-id="${room.roomId}">${room.name}</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>

<script>
</script>