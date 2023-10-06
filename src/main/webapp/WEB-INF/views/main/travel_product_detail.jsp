<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../base_view/header.jsp" %>
<%@ include file="../base_view/navigation.jsp" %>
<%--콤마 추가--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>어느 상품이 좋으세요?</title>
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
        padding-top: 3%;
        font-size: x-large;
        font-weight: bold;
    }

    .tag-div {
        flex: 2; /* 텍스트 영역이 이미지보다 더 넓게 설정 */
        align-self: flex-start; /* 텍스트를 세로로 맨 위에 정렬 */
        padding-top: 7%;
        font-size: medium;
    }

    .img img {
        width: 400px;
        height: 400px;
    }

    .coupon-form {
        display: flex;
        margin-top: 7%;
        margin-bottom: 7%;
    }

    button {
        padding: 10px 20px;
        background-color: #007BFF;
        color: #fff;
        border: none;
        border-radius: 3px;
        cursor: pointer;
    }

    .result {
        display: none;
        margin-top: 20px;
        padding: 10px;
        background-color: #e5f9e5;
        border: 1px solid #00a74a;
        border-radius: 3px;
    }

    #coupon-message {
        color: #00a74a;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="travel-container">
            <div class="img-container">
                <div class="img" style="display: inline-block;">
                    <img src="${product.image}">
                </div>
                <div class="text">
                    [${product.city}] ${product.name}${product.descriptions}
                    <br><br>
                    <fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원

                    <!-- 쿠폰 창 -->
                    <div class="coupon-form">
                        <input type="text" id="coupon-code" placeholder="쿠폰 코드를 입력하세요">
                        <button id="apply-coupon">적용</button>
                    </div>
                    <div class="result">
                        <p id="coupon-message"></p>
                    </div>

                    <fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원

                    <div class="tag-div">
                        <c:forEach var="tag" items="${product.tags}" varStatus="status">
                            # ${tag.tag}&nbsp;&nbsp;
                        </c:forEach>
                    </div>
                </div>
            </div>
            <br><br>
        </div>
    </div>
</div>
<script>
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
