<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
<title>어디로 여행을 떠날까요?</title>

<style>
    body {
        /*background-image: url('https://cdn.pixabay.com/photo/2020/03/18/14/48/clouds-4944276_640.jpg');*/
        background-image: url('https://cdn.pixabay.com/photo/2016/03/27/07/32/clouds-1282314_640.jpg');
        background-size: cover; /* 배경 이미지를 뷰포트에 맞게 확대/축소 */
        background-repeat: no-repeat; /* 배경 이미지 반복 비활성화 */
        background-attachment: fixed; /* 배경 이미지를 고정 (스크롤해도 배경 이미지가 고정됨) */
        background-position: center center; /* 배경 이미지를 중앙에 위치시킴 */
        height: 100vh; /* 화면 높이만큼 배경 이미지 표시 */
        width: 100%;
        max-width: 2000px;
        margin: 0 auto;
    }

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
    }

    /* 검색창 컨테이너 스타일 */
    .search-container {
        display: flex;
        justify-content: center; /* 가로 중앙 정렬 */
        width: 100%;
    }

    /* 검색창 스타일 */
    .search-box {
        margin-top: 5%;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 90%;
    }

    /* 검색 버튼 스타일 */
    .search-button {
        margin-top: 5%;
        padding: 10px 20px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 5px;
        margin-left: 10px;
        cursor: pointer;
    }

    /* 검색창 컨테이너 스타일 */
    .travel-container {
        margin-top: 5%;
        margin-bottom: 10%;
    }

    .img-container {
        display: flex;
        justify-content: space-between; /* 가로 간격을 동일하게 설정합니다. */
        gap: 30px;
    }

    .img-container a {
        flex: 1; /* 모든 <a> 태그의 너비를 동일하게 설정합니다. */
    }

    .img {
        flex: 1;
        margin-bottom: 10px;
        position: relative;
    }

    .img img {
        width: 100%;
        height: 320px;
        border-radius: 10px;
    }

    .img::before {
        content: "";
        position: absolute;
        width: 100%;
        height: 37%; /* 이미지 높이의 1/3 */
        bottom: 0;
        background: linear-gradient(to top, rgba(0, 0, 0.1, 0.8), transparent);
        border-radius: 10px;
    }

    .img-text {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        color: white; /* 텍스트 색상 설정 */
        padding: 10px; /* 텍스트 패딩 설정 */
        box-sizing: border-box;
    }

    .img p {
        font-size: large;
        font-weight: bold;
    }

    .img div {
        width: 90%;
    }

    .pagination {
        margin-bottom: 5%;
        text-align: center;
        padding-right: 5%;
        margin-top: 5%;
    }

    .pagination .page-item {
        display: inline;
        margin: 0 4px;
    }

    .pagination .page-link {
        padding: 10px 15px;
        border: 1px solid #000; /* 검은 색 테두리 */
        background-color: #000; /* 검은 배경색 */
        color: #fff; /* 흰색 텍스트 */
        border-radius: 4px; /* 둥근 모서리 */
    }

    .pagination .page-link:hover {
        background-color: #fff; /* Hover 시 배경색을 흰색으로 변경 */
        color: #000; /* Hover 시 텍스트 색을 검은색으로 변경 */
        border-color: #000; /* Hover 시 테두리 색을 검은색으로 변경 */
    }

    .pagination .page-item.active .page-link {
        background-color: #333; /* Optional: Active page background color */
        color: #fff; /* Optional: Active page text color */
        border-color: #333; /* Optional: Active page border color */
    }

    .pagination .page-link:focus {
        outline: none; /* Optional: Remove focus outline */
    }

    /* Optional: Adjust the style of previous and next buttons */
    .pagination .page-item:first-child .page-link {
        border-top-left-radius: 4px;
        border-bottom-left-radius: 4px;
    }

    .pagination .page-item:last-child .page-link {
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="search-container">
            <input type="text" class="search-box" id="searchInput" placeholder="어디로 여행을 떠날까요?">
            <button class="search-button" onclick="search(event)">검색</button>
        </div>
        <div class="travel-container" id="main_search_result">
            <h1>인기 많은 여행지 Top 4</h1>
            <div class="img-container">
                <c:forEach var="country" items="${countries4}">
                    <a href="/guest/country?country_id=${country.countryId}"
                       style="text-decoration: none; color: inherit;">
                        <div class="img">
                            <img src="${country.image}">
                            <div class="img-text">
                                <p>${country.country} - ${country.city}</p>
                                <p style="font-weight: normal; font-size: medium;">
                                    <img src='/images/like.png' class="like-img" style="width: 20px; height: 20px; vertical-align: middle; padding-top: 5px;">
                                    <span style="display: inline-block; vertical-align: middle;">
                                            ${country.totalLikes}
                                    </span>
                                </p>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
            <div class="travel-container">
                <h1>모든 여행지</h1>
                <div class="img-container">
                    <c:forEach var="country" items="${countries.content}">
                        <a href="/guest/country?country_id=${country.countryId}"
                           style="text-decoration: none; color: inherit;">
                            <div class="img">
                                <img src="${country.image}">
                                <div class="img-text">
                                    <p>${country.country} - ${country.city}</p>
                                    <p style="font-weight: normal; font-size: medium;">
                                        <img src='/images/like.png' class="like-img" style="width: 20px; height: 20px; vertical-align: middle; padding-top: 5px;">
                                        <span style="display: inline-block; vertical-align: middle;">
                                                ${country.totalLikes}
                                        </span>
                                    </p>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
                <!-- 페이징 처리 -->
                                    <ul class="pagination">
                        <c:choose>
                            <c:when test="${countries.totalPages-1 > 0}">
                    <c:forEach begin="1" end="${countries.totalPages-1}" varStatus="status">
                        <li class="page-item">
                            <a class="page-link" href="?page=${status.index}">${status.index}</a>
                        </li>
                    </c:forEach>
                            </c:when>
                        </c:choose>
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
    /** 최근 게시글 중 검색 */
    function search(event) {
        event.preventDefault();
        var keyword = document.getElementById('searchInput').value;
        $.ajax({
            type: 'POST',
            url: '/guest/search',
            data: {"keyword": keyword}, // 서버에 전달할 데이터
            success: function (response) {
                $("#main_search_result").html(response);
            },
            error: function (error) {

            }
        });
    }
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
