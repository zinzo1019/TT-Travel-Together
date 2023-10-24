<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    /* 기본 여백 제거 */
    body {
        margin: 0;
        padding: 0; /* 추가로 body의 padding도 제거해 주세요. */
    }

    header {
        position: fixed; /* 고정 위치 설정 */
        top: 0; /* 맨 위에 고정 */
        left: 0;
        right: 0; /* 화면 전체 너비로 확장 */
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px;
        background-color: #333;
        color: white;
        z-index: 1000; /* 다른 요소 위에 레이어 표시 */
        height: 30px;
    }

    /* 왼쪽 서비스 이름 스타일 */
    .service-name {
        font-size: 24px;
        font-weight: bold;
    }

    /* 오른쪽 환영 메시지 스타일 */
    .welcome-message {
        font-size: 16px;
    }

    .bold-white {
        font-weight: bold;
        color: white;
        text-decoration: none; /* 링크의 밑줄 제거 */
    }

    .welcome-message button {
        background-color: #333;
        color: #ffffff;
        border: none;
        margin: 5px;
        cursor: pointer;
        font-weight: bold;
        font-size: 15px;
    }
</style>
</head>
<body>
<header>
    <div class="service-name"> TT | Travel Together</div>
<%--    로그인 상태--%>
    <c:if test="${not empty pageContext.request.userPrincipal }">
        <div class="welcome-message">
            <a href="/user/mypage/modify/user" class="bold-white">${user.name}</a> 님, 반갑습니다!
        </div>
    </c:if>
<%--    로그아웃 상태--%>
    <c:if test="${empty pageContext.request.userPrincipal }">
    <div class="welcome-message">
        <button type="button" onclick="location.href='/login'">로그인</button>
        <button type="button" onclick="location.href='signup'">회원가입</button>
    </div>
    </c:if>
</header>
</body>

