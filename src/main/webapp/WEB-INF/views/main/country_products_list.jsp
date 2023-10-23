<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<title>어느 상품이 좋으세요?</title>
<style>
    body {
        /*background-image: url('https://cdn.pixabay.com/photo/2020/03/18/14/48/clouds-4944276_640.jpg');*/
        background-image: url('https://cdn.pixabay.com/photo/2016/03/27/07/32/clouds-1282314_640.jpg');
        background-size: cover; /* 배경 이미지를 뷰포트에 맞게 확대/축소 */
        background-repeat: no-repeat; /* 배경 이미지 반복 비활성화 */
        background-attachment: fixed; /* 배경 이미지를 고정 (스크롤해도 배경 이미지가 고정됨) */
        background-position: center center; /* 배경 이미지를 중앙에 위치시킴 */
        height: 100vh; /* 화면 높이만큼 배경 이미지 표시 */
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

    /* 검색창 컨테이너 스타일 */
    .travel-container {
        margin-top: 5%;
        margin-left: 1%;
    }

    .img-container {
        width: 100%;
        overflow: hidden; /* 넘치는 내용을 가리기 위해 */
        display: flex; /* Flexbox 레이아웃 사용 */
        align-items: center; /* 수직 가운데 정렬 */
        background-color: white;
        border-radius: 15px;
    }

    .img {
        float: left; /* 이미지를 왼쪽으로 띄움 */
        margin-right: 20px; /* 이미지 사이의 간격 설정 */
        flex: 1; /* 이미지가 늘어날 수 있도록 flex 속성을 설정 */
        padding-right: 20px; /* 이미지와 텍스트 사이의 간격 설정 */
    }

    .text {
        flex: 2; /* 텍스트 영역이 이미지보다 더 넓게 설정 */
        align-self: flex-start; /* 텍스트를 세로로 맨 위에 정렬 */
        padding-top: 1%;
        font-size: large;
        font-weight: bold;
        height: 180px;
        position: relative;
        border-radius: 15px;
    }

    .tag-div {
        flex: 2; /* 텍스트 영역이 이미지보다 더 넓게 설정 */
        align-self: flex-start; /* 텍스트를 세로로 맨 위에 정렬 */
        font-size: medium;
    }

    .img img {
        width: 200px;
        height: 200px;
        border-radius: 15px 0 0 15px;
    }

    .like-container {
        display: flex;
        justify-content: flex-start; /* 좌측 정렬 */
        align-items: center; /* 요소들을 수직 가운데로 정렬 */
        padding: 8px 0; /* 위아래 패딩 추가 */
        position: absolute;
        bottom: 0;
        width: 80%;
    }

    .like-img {
        width: 17px; /* 좋아요 이미지 크기 조정 */
        height: 17px;
        margin-right: 3px; /* 이미지 사이 간격 추가 */
        margin-top: 0.4%;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="search-container">
            <input type="text" class="search-box" id="searchInput" placeholder="어디로 여행을 떠날까요?">
            <button class="search-button" onclick="search(event)">검색</button>
        </div>
        <div class="travel-container" id="products_search_result">
            <h1>[${country.country} - ${country.city}] ${fn:length(products)}건의 여행지가 있어요!</h1>
            <c:forEach var="product" items="${products}">
                <div class="img-container">
                    <a href="/guest/product/detail?product_id=${product.id}"
                       style="text-decoration: none; color: inherit;">
                        <div class="img" style="display: inline-block;">
                            <img src="data:${product.type};base64,${product.encoding}">
                        </div>
                    </a>
                    <div class="text">
                        <a href="/guest/product/detail?product_id=${product.id}"
                           style="text-decoration: none; color: inherit;">
                            <div style="margin-top: 3%;">
                                <p style="padding-right: 5%;">
                                    [${country.city}] ${product.name}${product.descriptions}</p>
                                <div class="tag-div" style="font-weight: normal">
                                    <c:forEach var="tag" items="${product.tags}" varStatus="status">
                                        # ${tag.tag}&nbsp;&nbsp;
                                    </c:forEach>
                                </div>
                            </div>
                        </a>
                        <div class="like-container">
                            <p style="padding-right: 1%;"><fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원
                                | </p>
                                <%--    로그인 상태--%>
                            <c:if test="${not empty pageContext.request.userPrincipal }">
                                <img src="${product.userLiked ? '/images/like.png' : '/images/empty-like.png'}"
                                     class="like-img">
                                <p>${product.like}</p>
                            </c:if>
                                <%--    로그아웃 상태--%>
                            <c:if test="${empty pageContext.request.userPrincipal }">
                                <img src='/images/empty-like.png' class="like-img">
                                <p>${product.like}</p>
                            </c:if>
                        </div>
                    </div>
                </div>
                <br><br>
            </c:forEach>
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
            url: 'country/search?country_id=${country.countryId}',
            data: {"keyword": keyword}, // 서버에 전달할 데이터
            success: function (response) {
                $("#products_search_result").html(response);
            },
            error: function (error) {

            }
        });
    }
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
