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
        margin-bottom: 4%;
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
        background-color: whitesmoke;
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

    .payment-table {
        width: 100%; /* 테이블을 부모 요소에 맞게 확장합니다. */
        border-collapse: collapse; /* 테두리가 서로 겹치지 않도록 설정합니다. */
        border: 1px solid #ccc; /* 테이블 테두리 추가 */
        margin-top: 2%;
        margin-bottom: 5%;
        background-color: whitesmoke;
        border-radius: 15px;
    }

    .payment-table tr {
        border: 1px solid #ccc; /* 각 행에 테두리 추가 */
    }

    .payment-table td {
        padding: 10px 15px; /* 셀 내부 여백 추가 */
        border: 1px solid #ccc; /* 각 셀에 테두리 추가 */
    }

    .label {
        width: 12%;
        font-weight: bold; /* 레이블 텍스트를 굵게 표시 */
        text-align: center;
    }

    .refundButton {
        background-color: #333;
        color: white;
        border: none;
        padding: 5px 12px;
        border-radius: 4px;
        cursor: pointer;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="travel-container" id="products_search_result">
            <c:choose>
                <c:when test="${available == 2}">
                    <h1>${fn:length(products)}건의 이용 가능한 여행 상품이 있어요.</h1>
                </c:when>
                <c:when test="${available == 3}">
                    <h1>${fn:length(products)}건의 이용 불가능한 상품이 있어요.</h1>
                </c:when>
                <c:otherwise>
                    <h1>${user.name}님이 결제한 ${fn:length(products)}건의 여행 상품이 있어요!</h1>
                </c:otherwise>
            </c:choose>
            <div style="margin-bottom: 13%">
                <c:forEach var="product" items="${products}">
                    <div class="img-container">
                        <a href="/guest/product/detail?product_id=${product.productDto.id}"
                           style="text-decoration: none; color: inherit;">
                            <div class="img" style="display: inline-block;">
                                <img src="data:${product.productDto.type};base64,${product.productDto.encoding}"
                                     style="border-radius: 15px;">
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
                            <td class="label">상품 이름</td>
                            <td class="value">${product.productDto.productName}</td>
                        </tr>
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
                            <td class="value"><fmt:formatNumber value="${product.productDto.cost - product.paidAmount}"
                                                                pattern="#,###"/> 원
                            </td>
                        </tr>
                        <c:choose>
                            <c:when test="${product.available}">
                                <tr>
                                    <td class="label">사용 여부</td>
                                    <td class="value">
                                        사용 가능
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label">환불하기</td>
                                    <td class="value">
                                        <button class="refundButton" data-payment-id="${product.paymentId}">환불하기
                                        </button>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td class="label">사용 여부</td>
                                    <td class="value" style="color: red">
                                        사용 불가능 - ${product.reason}
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label">환불 사유</td>
                                    <td class="value">${product.refundReason}</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        <tr>
                            <td class="label">담당자</td>
                            <td class="value">${product.productDto.email}</td>
                        </tr>
                    </table>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script>
    /** 환불하기 버튼 클릭 이벤트 */
    $(".refundButton").click(function () {
        if (confirm("환불하시겠습니까?")) {
            var refundReason = prompt("환불 사유를 입력해주세요 (필수)");
            if (refundReason !== "") {
                var paymentId = $(this).data("payment-id");
                $.ajax({
                    url: "refund",
                    type: "POST",
                    data: {
                        "paymentId": paymentId,
                        "refundReason": refundReason
                    },
                    success: function (data) {
                        alert("환불 처리했습니다.");
                        location.reload();
                    },
                    error: function (error) {
                    }
                });
            } else {
                return false;
            }
        }
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
