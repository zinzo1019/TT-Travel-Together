<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        margin: 3% 0 5% 0;
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

    .popular-container {
        margin-bottom: 5%;
    }

    .img-container {
        display: flex;
        gap: 30px;
        height: 320px;
    }

    .shadowed {
        flex: 1; /* 모든 <a> 태그의 너비를 동일하게 설정합니다. */
        text-decoration: none;
        color: inherit;
        border: 0;
        box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.5);
        border-radius: 10px;
    }

    .img img {
        width: 100%;
        height: 320px;
        border-radius: 10px;
    }

    .img p {
        font-size: large;
        font-weight: bold;
    }

    .img div {
        width: 90%;
    }

    .product-img {
        border-radius: 10px;
        height: 350px;
    }

    .product-img img {
        width: 100%;
        height: 220px;
        border-radius: 10px 10px 0 0;
    }

    .product-info {
        text-align: left;
        padding: 5px;
        height: 120px;
        position: relative;
        background-color: whitesmoke;
        border-radius: 0 0 10px 10px;
    }

    .like-container {
        font-weight: normal;
        font-size: medium;
        position: absolute;
        bottom: 15%;
        left: 5%;
    }

    .pagination {
        margin-bottom: 13%;
        text-align: center;
        padding-right: 5%;
        margin-top: 5%;
    }

    .pagination .page-item {
        display: inline;
        margin: 0 4px;
    }

    .pagination .page-link {
        padding: 5px 10px;
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
            <div class="popular-container">
                <h1>최근 뜨는 여행 상품</h1>
                <div class="img-container" style="height: 350px;">
                    <c:forEach var="product" items="${productsTop4}">
                        <a href="/guest/product/detail?product_id=${product.travelProductId}" class="shadowed">
                            <div class="product-img" style="display: inline-block;">
                                <img src="data:${product.type};base64,${product.encoding}">
                                <div class="product-info">
                                    <p style="font-size: small; color: red; margin-bottom: 0;">${product.country}
                                        - ${product.city}</p>
                                    <p style="margin-top: 0; font-weight: bold;">${product.name}</p>
                                    <p style="font-weight: normal; font-size: medium; margin-bottom: 1px">
                                    <div class="like-container">
                                        <fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원
                                        <span style="opacity: 0.6;">/ 1인</span>
                                            <%--                                        <img src='/images/like.png' class="like-img"--%>
                                            <%--                                             style="width: 20px; height: 20px; vertical-align: middle; padding-top: 5px;">--%>
                                            <%--                                        <span style="display: inline-block; vertical-align: middle;">--%>
                                            <%--                                                ${product.like}--%>
                                            <%--                                        </span>--%>
                                    </div>
                                    </p>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
            <div class="popular-container">
                <h1>모든 여행 상품 둘러보기</h1>
                <div class="change-container">
                    <div class="img-container" style="height: 350px;">
                        <c:forEach var="product" items="${products.content}">
                            <a href="/guest/product/detail?product_id=${product.travelProductId}" class="shadowed"
                               style="flex: 0.25;">
                                <div class="product-img" style="display: inline-block;">
                                    <img src="data:${product.type};base64,${product.encoding}">
                                    <div class="product-info">
                                        <p style="font-size: small; color: red; margin-bottom: 0;">${product.country}
                                            - ${product.city}</p>
                                        <p style="margin-top: 0; font-weight: bold;">${product.name}</p>
                                        <p style="font-weight: normal; font-size: medium; margin-bottom: 1px">
                                        <div class="like-container">
                                            <fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원
                                            <span style="opacity: 0.6;">/ 1인</span>
                                        </div>
                                        </p>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                    <!-- 페이징 처리 -->
                    <ul class="pagination">
                        <c:choose>
                            <c:when test="${products.totalPages > 0}">
                                <c:forEach begin="1" end="${products.totalPages}" varStatus="status">
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
</div>
<script>
    /** 최근 게시글 중 검색 */
    function search(event) {
        event.preventDefault();
        var keyword = document.getElementById('searchInput').value;
        $.ajax({
            type: 'POST',
            url: 'products/search',
            data: {"keyword": keyword},
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