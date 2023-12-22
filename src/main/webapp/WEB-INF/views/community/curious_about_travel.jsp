<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<meta charset="UTF-8">
<title>여행에 대해 궁금해요.</title>
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
        margin-top: 4%;
    }

    .background-container {
        background-color: #f0f0f0; /* 원하는 배경 색상으로 설정 */
        padding: 20px; /* 내부 여백 추가 */
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        padding-bottom: 65px;
    }

    .search-container label {
        font-size: 15px; /* 라벨의 글꼴 크기 설정 */
    }

    .country-container {
        display: flex;
        align-items: center; /* 세로 중앙 정렬 */
    }

    .country-container label {
        flex: 1; /* 라벨 요소가 가능한 한 더 크게 확장됨 */
        font-size: 18px;
        font-weight: bold;
    }

    .country-container select, input {
        flex: 2; /* 입력 상자 요소가 라벨보다 두 배로 확장됨 */
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }

    /* 검색창 컨테이너 스타일 */
    .travel-container {
        margin-top: 5%;
        margin-left: 1%;
    }

    .header-container {
        display: flex;
        align-items: center;
    }

    .header-container h1 {
        margin: 0;
    }

    .header-container p {
        font-size: large;
        font-weight: bold;
        color: #555555;
    }

    /* 게시글 작성하기 버튼 */
    .post-button {
        padding: 10px 20px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 5px;
        margin-left: 10px;
        cursor: pointer;
    }

    /* 게시글 스타일 */
    .post {
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 15px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .search-button {
        background-color: #333;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        position: absolute;
        bottom: 7%;
        right: 2.5%;
    }

    .post h2 {
        margin: 0;
    }

    .post p {
        font-size: 16px;
    }

    /* 게시글 목록 스타일 */
    .post-list {
        list-style: none;
        padding: 0;
    }

    .post-list-item {
        margin-bottom: 10px;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="background-container">
            <div class="country-container">
                <label> 어느 나라가 궁금한가요? </label>
                <select id="options" name="options">
                    <option value="0">선택 없음</option>
                    <c:forEach items="${options}" var="option">
                        <option value="${option.countryId}">
                                ${option.country} - ${option.city}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label> 무엇이 궁금한가요? </label>
                <input type="text" id="keyword" placeholder="한국 문화에 대해 궁금해">
                <button class="search-button" id="search-button">검색하기</button>
            </div>
        </div>
        <div class="travel-container" id="curious_search_result">
            <div class="header-container">
                <div style="flex: 1; display: flex; align-items: center;">
                    <h1>여행에 대해 궁금해요!</h1>
                    <p style="margin-left: 2%">${fn:length(posts)}건의 질문</p>
                </div>
                <button class="post-button" id="postButton">게시글 작성하기</button>
            </div>
            <ul class="post-list">
                <c:forEach var="post" items="${posts}">
                    <li class="post-list-item">
                        <a href="curious/view?postId=${post.postId}" style="text-decoration: none; color: inherit;">
                            <div class="post">
                                <p style="color: red; font-size: 13px; font-weight: bold;">${post.country} - ${post.city}</p>
                                <h2>${post.title}</h2>
                                <p style="margin: 3% 0">${post.content}</p>
                            </div>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>

<script>
    /** 게시글 작성하기 버튼 클릭 -> 작성하기 페이지 */
    var postButton = document.getElementById('postButton'); // 게시글 작성 버튼
    postButton.addEventListener('click', function () {
        window.location.href = 'curious/post';
    });

    /** 검색 버튼 클릭 이벤트 핸들러 */
    $("#search-button").click(function () {
        var countryId = $("#options").val(); // 나라 아이디
        var keyword = $("#keyword").val(); // 검색어
        $.ajax({
            url: "curious/search",
            method: "POST",
            data: {
                countryId: countryId,
                keyword: keyword
            },
            success: function (response) {
                $("#curious_search_result").html(response);
            },
            error: function (error) {
            }
        });
    });
</script>
    </body>
</html>
<%@ include file="../base_view/footer.jsp" %>
