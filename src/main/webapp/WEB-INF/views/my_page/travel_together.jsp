<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
<title>마이 페이지 - 같이 여행 가요!</title>
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

    .search-container label {
        font-size: 15px; /* 라벨의 글꼴 크기 설정 */
    }

    /* 검색창 컨테이너 스타일 */
    .travel-container {
        margin-top: 5%;
        margin-left: 1%;
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
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
    }

    /** 지원하기 / 취소하기 / 지원마감 버튼 */
    .support-button {
        background-color: #333;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        position: absolute; /* 절대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        top: 10%; /* 위에서 10px 떨어진 위치 */
        right: 2%; /* 오른쪽에서 10px 떨어진 위치 */
    }

    .post h2 {
        margin: 0;
    }

    .post p {
        font-size: 16px;
        margin: 3% 0%;
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
        <div class="travel-container" id="together_search_result">
            <div class="header-container">
                <div style="flex: 1; display: flex; align-items: center;">
                    <h1>나의 '같이 여행 가요!'</h1>
                    <p style="margin-left: 2%">${fn:length(postsByTrue)}건의 여행 모집</p>
                </div>
                <button class="post-button" id="postButton">게시글 작성하기</button>
            </div>
            <ul class="post-list" id="postList">
                <%--                모집 마감 전--%>
                <c:forEach var="post" items="${postsByTrue}">
                    <li class="post-list-item">
                        <a href="/user/community/together/view?postId=${post.postId}"
                           style="text-decoration: none; color: inherit;">
                            <div class="post">
                                <p style="margin: 1% 0; color: red; font-weight: bold; font-size: 13px;">${post.recruitedNumber}명이 함께하고 있어요!</p>
                                <h2>${post.title}</h2>
                                <p>${post.content}</p>
                                <!-- 만약 현재 사용자가 글의 작성자라면 '모집 마감하기' 버튼을 표시 -->
                                <button class="support-button closeRecruitmentButton" data-post-id="${post.postId}"
                                        style="background-color: #1633b9">모집 마감하기
                                </button>
                                <c:choose>
                                    <c:when test="${post.remainingDays eq 0}">
                                        <%--                                        지원 마감 날짜가 오늘이라면--%>
                                        <p style="position: absolute; top: 18%; right: 2%; font-size: small">모집 마감
                                            D-DAY</p>
                                    </c:when>
                                    <c:otherwise>
                                        <%--                                        지원 마감 날짜가 오늘이 아니라면--%>
                                        <p style="position: absolute; top: 18%; right: 2%; font-size: small">모집 마감
                                            D-${post.remainingDays}</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </a>
                    </li>
                </c:forEach>
                <%--                모집 마감 후--%>
                <c:forEach var="post" items="${postsByFalse}">
                    <li class="post-list-item">
                        <a href="/user/community/together/view?postId=${post.postId}"
                           style="text-decoration: none; color: inherit;">
                            <div class="post">
                                <p style="margin: 1% 0; color: red; font-weight: bold; font-size: 13px;">${post.recruitedNumber}명이 함께하고 있어요!</p>
                                <h2>${post.title}</h2>
                                <p>${post.content}</p>
                                <button class="support-button">모집 마감</button>
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
        window.location.href = '/user/community/together/post';
    });

    /** '모집 마감하기' 버튼 클릭 이벤트 핸들러 */
    $(document).ready(function () {
        $(".closeRecruitmentButton").click(function () {
            var postId = $(this).data("post-id");
            $.ajax({
                url: "/user/community/together/close?postId=" + postId,
                method: "POST",
                success: function (data) {
                    alert("모집이 마감되었습니다.");
                    location.reload();
                },
                error: function (error) {
                    alert("모집 마감에 실패했습니다.");
                }
            });
        });
    });

    /** '지원하기' 버튼 클릭 이벤트 핸들러 */
    $(document).ready(function () {
        $(".pushRecruitmentButton").click(function () {
            var postId = $(this).data("post-id");
            $.ajax({
                url: "/user/community/together/apply?postId=" + postId,
                method: "POST",
                success: function (data) {
                    alert("지원을 완료했습니다.");
                    location.reload();
                },
                error: function (xhr, status, error) {
                    alert(xhr.responseText);
                    location.reload();
                }
            });
        });
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
