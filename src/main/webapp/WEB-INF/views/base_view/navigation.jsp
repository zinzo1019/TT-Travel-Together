<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    /* 네비게이션 바 스타일 */
    nav {
        position: fixed;
        top: 50px; /* 헤더의 높이만큼 여백 추가 */
        left: 0;
        width: 18%; /* 화면 너비의 18%로 설정 */
        height: 100%; /* 화면 전체 높이에 맞추세요. */
        background-color: #333;
        color: white;
    }

    nav ul {
        list-style-type: none;
        margin: 0;
        margin-top: 15%;
        padding: 0;
    }

    nav ul li {
        margin: 10px 0;
    }

    nav ul li a {
        display: block;
        text-decoration: none;
        color: white;
        font-weight: bold;
        padding: 10px;
    }

    /* 네비게이션 바 hover 스타일 */
    nav ul li a:hover {
        background-color: #555;
    }

    .child-title {
        margin-left: 10%;
        padding: 5px;
    }

    .parent-board {
        padding: 10px;
        font-weight: bold;
    }
</style>

<nav>
    <ul>
        <li><a href="/">어디로 여행을 떠날까요?</a></li>

        <li class="parent-board">커뮤니티</li>
        <li><a href="/ROLE_USER/community/together" class="child-title">같이 여행 가요!</a></li>
        <li><a href="/ROLE_USER/community/curious" class="child-title">여행에 대해 궁금해요.</a></li>

        <li class="parent-board">나의 여행</li>
        <li><a href="/ROLE_USER/my_travel/upcoming_travel" class="child-title">곧 여기로 떠나요!</a></li>
        <li><a href="/ROLE_USER/my_travel/interesting_travel" class="child-title">이 여행지에 관심있어요.</a></li>

        <li class="parent-board">마이 페이지</li>
        <li><a href="" class="child-title">나의 '같이 여행 가요!'</a></li>
        <li><a href="" class="child-title">나의 '여행에 대해 궁금해요.'</a></li>

        <%--    로그인 상태--%>
        <c:if test="${not empty pageContext.request.userPrincipal }">
            <li class="parent-board"><a href="/logout">로그아웃</a></li>
        </c:if>

    </ul>
</nav>