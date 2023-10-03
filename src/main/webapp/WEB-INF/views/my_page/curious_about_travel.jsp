<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../base_view/header.jsp" %>
<%@ include file="../base_view/navigation.jsp" %>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>여행에 대해 궁금해요!</title>
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
        border-radius: 5px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
    }

    .post h2 {
        font-size: 24px;
        margin-bottom: 10px;
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
        <div class="travel-container">
            <div class="header-container">
                <div style="flex: 1; display: flex; align-items: center;">
                    <h1>나의 '여행에 대해 궁금해요!'</h1>
                    <p style="margin-left: 2%">5건의 질문</p>
                </div>
            </div>

            <ul class="post-list">
                <li class="post-list-item">
                    <div class="post">
                        <h2>게시글 제목 1</h2>
                        <p>게시글 내용 1...</p>
                    </div>
                </li>
                <li class="post-list-item">
                    <div class="post">
                        <h2>게시글 제목 2</h2>
                        <p>게시글 내용 2...</p>
                    </div>
                </li>
                <li class="post-list-item">
                    <div class="post">
                        <h2>게시글 제목 2</h2>
                        <p>게시글 내용 2...</p>
                    </div>
                </li>
                <li class="post-list-item">
                    <div class="post">
                        <h2>게시글 제목 2</h2>
                        <p>게시글 내용 2...</p>
                    </div>
                </li>
                <li class="post-list-item">
                    <div class="post">
                        <h2>게시글 제목 2</h2>
                        <p>게시글 내용 2...</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
