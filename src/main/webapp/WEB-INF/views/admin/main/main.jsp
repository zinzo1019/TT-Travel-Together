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
    }

    .img-container {
        display: flex;
        gap: 30px;
        justify-content: flex-start; /* 왼쪽 정렬 (기본값) */
    }

    .img {
        flex: 1;
        margin-bottom: 10px;
    }

    .img img {
        width: 200px;
        height: 200px;
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
        border: 1px solid #ddd; /* Optional: Border style */
        background-color: #f8f9fa; /* Optional: Background color */
        color: #333; /* Optional: Text color */
        border-radius: 4px; /* Optional: Rounded corners */
    }

    .pagination .page-link:hover {
        background-color: #333; /* Optional: Hover background color */
        color: #fff; /* Optional: Hover text color */
        border-color: #333; /* Optional: Hover border color */
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
            <h1>최근 뜨는 여행지</h1>
            <div class="img-container">
                <c:forEach var="country" items="${countries4}">
                    <a href="/ROLE_ADMIN/country?country_id=${country.countryId}"
                       style="text-decoration: none; color: inherit;">
                        <div class="img" style="display: inline-block; margin-right: 20px;">
                            <img src="${country.image}">
                            <div>
                                <p>${country.country} - ${country.city}</p>
                                <p style="font-weight: normal; font-size: medium">좋아요 ${country.totalLikes}</p>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
            <div class="travel-container">
                <h1>이 여행지는 어떠세요?</h1>
                <div class="img-container">
                    <c:forEach var="country" items="${countries.content}">
                        <a href="/ROLE_ADMIN/country?country_id=${country.countryId}"
                           style="text-decoration: none; color: inherit;">
                            <div class="img" style="display: inline-block; margin-right: 20px;">
                                <img src="${country.image}">
                                <div>
                                    <p>${country.country} - ${country.city}</p>
                                    <p style="font-weight: normal; font-size: medium">좋아요 ${country.totalLikes}</p>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
                <!-- 페이징 처리 -->
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <c:forEach begin="2" end="${countries.totalPages-1}" varStatus="status">
                        <li class="page-item">
                            <a class="page-link" href="?page=${status.index}">${status.index-1}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
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
            url: '/ROLE_GUEST/search',
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
