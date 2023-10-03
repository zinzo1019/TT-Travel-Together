<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../base_view/header.jsp" %>
<%@ include file="../base_view/navigation.jsp" %>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>여행에 대해 궁금해요!</title>
<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- datepicker 라이브러리 추가 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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

    /* 검색창 컨테이너 스타일 */
    .travel-container {
        margin-top: 5%;
        margin-left: 1%;
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
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
    }

    /** 지원하기 / 취소하기 / 지원마감 버튼 */
    .search-button {
        background-color: #666;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        position: absolute; /* 절대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        bottom: 7%;
        right: 2.5%;
    }

    /** 지원하기 / 취소하기 / 지원마감 버튼 */
    .support-button {
        background-color: #666;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        position: absolute; /* 절대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        top: 10%; /* 위에서 10px 떨어진 위치 */
        right: 2%; /* 오른쪽에서 10px 떨어진 위치 */
    }

    /** 마감까지 남은 날짜 */
    .end-date-p {
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        position: absolute; /* 절대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        top: 30%; /* 위에서 10px 떨어진 위치 */
        right: 0.5%; /* 오른쪽에서 10px 떨어진 위치 */
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
                    <h1>나의 '같이 여행 가요!'</h1>
                    <p style="margin-left: 2%">5건의 여행 모집</p>
                </div>
            </div>
            <ul class="post-list">
                <li class="post-list-item">
                    <div class="post">
                        <h2>게시글 제목 1</h2>
                        <p>게시글 내용 1...</p>
                        <button class="support-button">지원 마감하기</button>
                        <p class="end-date-p">D-27</p>
                    </div>
                </li>
                <li class="post-list-item">
                    <div class="post">
                        <h2>게시글 제목 2</h2>
                        <p>게시글 내용 2...</p>
                        <button class="support-button">지원 마감</button>
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
<script>
    // 선택지 변경 이벤트 처리
    const selectBox = document.getElementById("options");
    selectBox.addEventListener("change", () => {
        // 선택한 값을 가져옴
        const selectedValue = selectBox.value;
        console.log("선택한 값: " + selectedValue);
    });

    $(function () {
        // 시작 날짜 선택
        $("#start-date").datepicker({
            dateFormat: "yy-mm-dd", // 날짜 형식 설정 (예: 2023-09-30)
            onSelect: function (dateText) {
                // 선택한 날짜를 텍스트 필드에 설정
                $("#start-date").val(dateText);
            }
        });

        // 끝 날짜 선택
        $("#end-date").datepicker({
            dateFormat: "yy-mm-dd", // 날짜 형식 설정 (예: 2023-09-30)
            onSelect: function (dateText) {
                // 선택한 날짜를 텍스트 필드에 설정
                $("#end-date").val(dateText);
            }
        });
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
