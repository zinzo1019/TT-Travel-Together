<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>관리자 - 결제 관리 페이지</title>
<style>
    .content {
        margin-left: 18%; /* 네비게이션 바의 넓이와 일치하도록 설정 */
        padding: 20px; /* 적절한 여백 */
        display: flex;
        justify-content: center; /* 가로 중앙 정렬 */
        overflow-y: auto; /* 네비게이션 바 내용이 화면을 벗어날 경우 스크롤 바 추가 */
    }

    .main-container {
        width: 70%;
        padding: 20px; /* 내부 여백 추가 */
        margin-top: 4%;
    }

    /* 세로 줄 */
    .vertical-line {
        border-left: 2px solid rgba(0, 0, 0, 0.2); /* 세로 줄 스타일 지정 */
        margin-left: 5px; /* 세로 줄과 이미지 사이 여백 조절 */
    }

    .img-container {
        width: 98%;
        margin-bottom: 25px;
        background-color: whitesmoke;
        border: 1px solid #ccc;
        border-radius: 15px;
        padding: 2% 0 2% 2%;
        box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2); /* 오른쪽과 아래 방향 그림자 추가 */
        height: 100px;
    }

    .product-container {
        padding-left: 1%;
    }

    .date-p {
        padding-bottom: 1%;
        color: rgba(68, 68, 68, 0.81);
    }

    .img {
        float: left; /* 이미지를 왼쪽으로 띄움 */
        flex: 1; /* 이미지가 늘어날 수 있도록 flex 속성을 설정 */
        padding-right: 20px; /* 이미지와 텍스트 사이의 간격 설정 */
        display: inline-block;
    }

    .text {
        flex: 2; /* 텍스트 영역이 이미지보다 더 넓게 설정 */
        align-self: flex-start; /* 텍스트를 세로로 맨 위에 정렬 */
        font-size: medium;
        display: inline-block;
        padding-left: 10px;
    }

    .img img {
        width: 100px;
        height: 100px;
        border-radius: 15px;
    }

    .button-container button {
        background-color: #333;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <h1>${fn:length(refunds)}건의 여행 상품 환불건이 있어요.</h1>
        <h3 id="currentYear"></h3>
        <div class="vertical-line" style="margin-bottom: 13%">
            <c:forEach var="refund" items="${refunds}">
                <div class="product-container">
                    <p class="date-p">
                        <c:set var="month" value="${refund.refundDate.month.value}"/>
                        <c:set var="day" value="${refund.refundDate.dayOfMonth}"/>
                        <c:set var="dayOfWeek" value="${refund.refundDate.dayOfWeek}"/>
                            ${month}월 ${day}일 (${dayOfWeek == DayOfWeek.MONDAY ? '월'
                            : dayOfWeek == DayOfWeek.TUESDAY ? '화'
                            : dayOfWeek == DayOfWeek.WEDNESDAY ? '수'
                            : dayOfWeek == DayOfWeek.THURSDAY ? '목'
                            : dayOfWeek == DayOfWeek.FRIDAY ? '금'
                            : dayOfWeek == DayOfWeek.SATURDAY ? '토'
                            : '일'})
                    </p>
                    <div class="img-container">
                        <a href="/guest/product/detail?product_id=${refund.productId}"
                           style="text-decoration: none; color: inherit;">
                            <div class="img" style="display: inline-block;">
                                <img src="data:${refund.type};base64,${refund.encoding}">
                            </div>
                        </a>
                        <div class="text">
                            <a href="/guest/product/detail?product_id=${refund.productId}"
                               style="text-decoration: none; color: inherit;">
                                <p style="font-weight: bold;">${refund.productName}</p>
                                <fmt:formatNumber value="${refund.cost}" pattern="#,###"/>원 ->
                                <span style="color: red"><fmt:formatNumber value="${refund.paidAmount}" pattern="#,###"/>원</span>
                                <div style="margin-top: 15px;">
                                    <span style="font-weight: bold">환불 사유:</span>
                                    <span>${refund.refundReason}</span>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</div>
<script>
    /** 현재 년도 */
    const currentYear = new Date().getFullYear(); // 현재 년도
    const yearElement = document.getElementById("currentYear");
    yearElement.textContent = currentYear + "년";
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
