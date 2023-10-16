<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title>곧 여기로 떠나요!</title>
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

    /* 검색창 컨테이너 스타일 */
    .travel-container {
        margin-top: 5%;
        margin-left: 1%;
    }

    .img-container {
        width: 98%;
        overflow: hidden; /* 넘치는 내용을 가리기 위해 */
        display: flex; /* Flexbox 레이아웃 사용 */
        align-items: center; /* 수직 가운데 정렬 */
        background-color: #eeeeee;
        border: 1px solid #ccc; /* 테두리 추가 */
        border-radius: 15px;
        padding: 2% 0 2% 2%;
    }

    .img {
        float: left; /* 이미지를 왼쪽으로 띄움 */
        flex: 1; /* 이미지가 늘어날 수 있도록 flex 속성을 설정 */
        padding-right: 20px; /* 이미지와 텍스트 사이의 간격 설정 */
    }

    .text {
        flex: 2; /* 텍스트 영역이 이미지보다 더 넓게 설정 */
        align-self: flex-start; /* 텍스트를 세로로 맨 위에 정렬 */
        font-size: medium;
        font-weight: bold;
        margin-top: 1%;
    }

    .img img {
        width: 100px;
        height: 100px;
    }

    hr {
        border: 1px solid #919191;
    }

    .payment-table {
        width: 100%; /* 테이블을 부모 요소에 맞게 확장합니다. */
        border-collapse: collapse; /* 테두리가 서로 겹치지 않도록 설정합니다. */
        border: 1px solid #ccc; /* 테이블 테두리 추가 */
        margin-top: 2%;
    }

    .payment-table tr {
        border: 1px solid #ccc; /* 각 행에 테두리 추가 */
    }

    .payment-table td {
        padding: 10px; /* 셀 내부 여백 추가 */
        border: 1px solid #ccc; /* 각 셀에 테두리 추가 */
    }

    .label {
        width: 12%;
        font-weight: bold; /* 레이블 텍스트를 굵게 표시 */
    }

    .value {
        padding-left: 10px; /* 값 텍스트와 레이블 사이 여백 추가 */
    }

</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="travel-container" id="products_search_result">
            <h1>${user.name}님이 결제한 ${fn:length(products)}건의 여행 상품이 있어요.</h1>
            <div style="margin-bottom: 5%">
            <c:forEach var="product" items="${products}">
                <div class="img-container">
                    <a href="/guest/product/detail?product_id=${product.productDto.id}"
                       style="text-decoration: none; color: inherit;">
                        <div class="img" style="display: inline-block;">
                            <img src="data:${product.productDto.type};base64,${product.productDto.encoding}"
                                 class="img-fluid">
                        </div>
                    </a>
                    <div class="text">
                        <a href="/guest/product/detail?product_id=${product.productDto.id}"
                           style="text-decoration: none; color: inherit;">
                            <p style="font-size: small; color: red">[${product.productDto.country}
                                - ${product.productDto.city}]</p>
                            <p>${product.productDto.name}${product.productDto.descriptions}</p>
                            <fmt:formatNumber value="${product.productDto.cost}" pattern="#,###"/> 원
                        </a>
                    </div>
                </div>
                <table class="payment-table">
                    <tr>
                        <td class="label">결제 방법</td>
                        <td class="value">${product.pgProvider == 'kakaopay' ? '카카오페이' : product.pgProvider}</td>
                    </tr>
                    <tr>
                        <td class="label">결제 날짜</td>
                        <td class="value">${product.createDate}</td>
                    </tr>
                    <tr>
                        <td class="label">결제 금액</td>
                        <td class="value"><fmt:formatNumber value="${product.paidAmount}" pattern="#,###"/> 원</td>
                    </tr>
                    <tr>
                        <td class="label">할인 금액</td>
                        <td class="value"><fmt:formatNumber value="${product.productDto.cost - product.paidAmount}" pattern="#,###"/> 원</td>
                    </tr>
                    <tr>
                        <td class="label">상품 설명</td>
                        <td class="value">${product.productDto.description}</td>
                    </tr>
                    <tr>
                        <td class="label">사용 여부</td>
                        <td class="value">${product.available ? '사용 가능' : '사용 완료'}</td>
                    </tr>
                </table>
            </div>
            </c:forEach>
        </div>
    </div>
</div>
<script>
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
