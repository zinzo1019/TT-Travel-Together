<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://cdn.ckeditor.com/4.17.1/standard/ckeditor.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

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
    <!-- jQuery 포함 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- jQuery UI 포함 -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- jQuery UI CSS 포함 (선택 사항) -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<meta charset="UTF-8">
<title>같이 여행 가요!</title>
<style>
    /*body {*/
    /*    !*background-image: url('https://cdn.pixabay.com/photo/2020/03/18/14/48/clouds-4944276_640.jpg');*!*/
    /*    background-image: url('https://cdn.pixabay.com/photo/2016/03/27/07/32/clouds-1282314_640.jpg');*/
    /*    background-size: cover; !* 배경 이미지를 뷰포트에 맞게 확대/축소 *!*/
    /*    background-repeat: no-repeat; !* 배경 이미지 반복 비활성화 *!*/
    /*    background-attachment: fixed; !* 배경 이미지를 고정 (스크롤해도 배경 이미지가 고정됨) *!*/
    /*    background-position: center center; !* 배경 이미지를 중앙에 위치시킴 *!*/
    /*    height: 100vh; !* 화면 높이만큼 배경 이미지 표시 *!*/
    /*}*/

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
        border-radius: 15px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
    }

    .search-button {
        background-color: #333;
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
        <div class="background-container">
            <div class="country-container">
                <label>어느 나라로 갈까요?</label>
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
                <label>언제 갈까요?</label>
                <input type="text" id="start-date" placeholder="날짜 선택">
                <input type="text" id="end-date" placeholder="날짜 선택">
                <button class="search-button" id="search-button">검색하기</button>
            </div>
        </div>
        <div class="travel-container" id="together_search_result">
            <div class="header-container">
                <div style="flex: 1; display: flex; align-items: center;">
                    <h1>같이 여행 가요!</h1>
                    <p style="margin-left: 2%">${fn:length(postsByTrue)}건의 여행 모집</p>
                </div>
                <button class="post-button" id="postButton">게시글 작성하기</button>
            </div>
            <ul class="post-list" id="postList">
                <%--                모집 마감 전--%>
                <c:forEach var="post" items="${postsByTrue}">
                    <li class="post-list-item">
                        <a href="together/view?postId=${post.postId}" style="text-decoration: none; color: inherit;">
                            <div class="post">
                                <p style="margin: 1% 0; color: red; font-weight: bold; font-size: 13px;">${post.recruitedNumber}명이 함께하고 있어요!</p>
                                <h2>${post.title}</h2>
                                <p>${post.content}</p>
                                <c:choose>
                                    <c:when test="${post.email eq user.email}">
                                        <!-- 만약 현재 사용자가 글의 작성자라면 '모집 마감하기' 버튼을 표시 -->
                                        <button class="support-button closeRecruitmentButton" data-post-id="${post.postId}" style="background-color: darkblue">모집 마감하기</button>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- post.isSupported 변수를 사용하여 버튼을 설정 -->
                                        <c:choose>
                                            <c:when test="${post.supported}"> <!-- post.isSupported 변수가 true일 경우 -->
                                                <button class="support-button cancelSupportButton" data-post-id="${post.postId}" style="background-color: darkred">지원 취소하기</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="support-button pushRecruitmentButton" data-post-id="${post.postId}" style="background-color: red">지원하기</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
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
                    <a href="together/view?postId=${post.postId}" style="text-decoration: none; color: inherit;">
                    <li class="post-list-item">
                        <div class="post">
                            <p style="margin: 1% 0; color: red; font-weight: bold; font-size: 13px;">${post.recruitedNumber}명이 함께하고 있어요!</p>
                            <h2>${post.title}</h2>
                            <p>${post.content}</p>
                            <button class="support-button">모집 마감</button>
                        </div>
                    </li>
                    </a>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<script>
    // 선택지 변경 이벤트 처리
    const selectBox = document.getElementById("options");
    selectBox.addEventListener("change", () => {
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

    /** 날짜 유효성 검사 */
    function validation() {
        var currentDate = new Date(); // 현재 날짜
        var startDateValue = document.getElementById('start-date').value; // 시작 날짜
        var endDateValue = document.getElementById('end-date').value; // 마감 날짜
        var startDate = new Date(startDateValue); // Date 타입 변환
        var endDate = new Date(endDateValue);

        if (startDateValue > endDateValue) {
            alert('시작 날짜는 종료 날짜보다 이후일 수 없습니다.');
            return false;
        }
        if (startDate < currentDate) {
            alert('시작 날짜는 현재 날짜보다 이전일 수 없습니다.');
            return false;
        }
        if (endDate < currentDate) {
            alert('종료 날짜는 현재 날짜보다 이전일 수 없습니다.');
            return false;
        } else return true;
    }

    /** 검색 버튼 클릭 이벤트 핸들러 */
    $("#search-button").click(function () {
        var countryId = $("#options").val(); // 나라 아이디
        var startDate = $("#start-date").val(); // 시작 날짜
        var endDate = $("#end-date").val(); // 마지막 날짜

        var dateCheck = true;
        if (startDate !== '' && endDate !== '') { // 시작 날짜와 마지막 날짜가 모두 존재하는 경우
            dateCheck = validation(); // 유효성 검사 함수 호출
        }

        if (dateCheck) { // 유효성 검사에 통과했다면
            $.ajax({
                url: "together/search",
                method: "POST",
                data: {
                    countryId: countryId,
                    startDate: startDate,
                    endDate: endDate
                },
                success: function (response) {
                    $("#together_search_result").html(response);
                },
                error: function (error) {
                }
            });
        }
    });

    /** 게시글 작성하기 버튼 클릭 -> 작성하기 페이지 */
    var postButton = document.getElementById('postButton'); // 게시글 작성 버튼
    postButton.addEventListener('click', function () {
        window.location.href = 'together/post';
    });

    /** '모집 마감하기' 버튼 클릭 이벤트 핸들러 */
    $(document).ready(function () {
        $(".closeRecruitmentButton").click(function () {
            var postId = $(this).data("post-id");
            $.ajax({
                url: "together/close?postId=" + postId,
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
                url: "together/apply?postId=" + postId,
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

        /** 지원 취소하기 */
        $(document).on("click", ".cancelSupportButton", function () {
            var postId = $(this).data("post-id");
            $.ajax({
                type: "POST",
                url: "together/cancel?postId=" + postId,
                success: function (data) {
                    alert("지원을 취소했습니다..");
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
