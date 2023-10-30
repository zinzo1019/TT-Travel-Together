<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;
            width: 30%;
        }

        .login-container h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            text-align: left;
            margin-left: 10%;
        }

        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 80%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-group button {
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #555;
        }
        .error-message {
            background-color: #f8d7da; /* 배경 색상 */
            color: #721c24; /* 텍스트 색상 */
            border: 1px solid #f5c6cb; /* 테두리 스타일 */
            padding: 10px; /* 패딩 */
            margin-bottom: 10px; /* 아래쪽 여백 */
            border-radius: 0.25rem; /* 둥근 테두리 */
        }

        .error-message p {
            margin: 0; /* 문단 간격 제거 */
            font-weight: bold; /* 굵은 글씨 */
        }
    </style>
</head>
<body>
<div class="login-container">
    <form action="/login" method="post">
        <c:if test="${param.error != null}">
            <div class="error-message">
                <p style="font-weight: bold; padding: 0;">로그인 실패</p>
                <p style="color: red">${error_message}</p>
            </div>
        </c:if>

        <h2>회원 로그인</h2>
        <div class="form-group">
            <label for="email">이메일</label>
            <input type="text" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required autocomplete="current-password">
        </div>
        <div class="form-group">
            <button type="submit">로그인</button>
        </div>
    </form>
</div>
</body>
</html>