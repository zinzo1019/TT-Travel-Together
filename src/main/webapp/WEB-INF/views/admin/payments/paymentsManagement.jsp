<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
        position: relative;
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

    .button-container {
        margin-top: 2%;
        position: absolute;
        top: 3%;
        right: 3%;
    }

    .button-container button {
        background-color: #333;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
    }

    .payment-table {
        width: 100%; /* 테이블을 부모 요소에 맞게 확장합니다. */
        border-collapse: collapse; /* 테두리가 서로 겹치지 않도록 설정합니다. */
        border: 1px solid #ccc; /* 테이블 테두리 추가 */
        margin-top: 2%;
        margin-bottom: 5%;
        background-color: whitesmoke;
        border-radius: 15px;
        margin-left: 1%;
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
</style>
<body>
<div class="content">
    <div class="main-container">
        <h1>${fn:length(payments)}건의 여행 상품 결제건이 있어요.</h1>
        <h3 id="currentYear"></h3>
        <div class="vertical-line" style="margin-bottom: 13%">
            <c:forEach var="payment" items="${payments}">
                <div class="product-container">
                    <p class="date-p">
                        <c:set var="month" value="${payment.createDate.month.value}"/>
                        <c:set var="day" value="${payment.createDate.dayOfMonth}"/>
                        <c:set var="dayOfWeek" value="${payment.createDate.dayOfWeek}"/>
                            ${month}월 ${day}일 (${dayOfWeek == DayOfWeek.MONDAY ? '월'
                            : dayOfWeek == DayOfWeek.TUESDAY ? '화'
                            : dayOfWeek == DayOfWeek.WEDNESDAY ? '수'
                            : dayOfWeek == DayOfWeek.THURSDAY ? '목'
                            : dayOfWeek == DayOfWeek.FRIDAY ? '금'
                            : dayOfWeek == DayOfWeek.SATURDAY ? '토'
                            : '일'})
                    </p>
                    <div class="img-container">
                        <a href="/guest/product/detail?product_id=${payment.productId}"
                           style="text-decoration: none; color: inherit;">
                            <div class="img" style="display: inline-block;">
                                <img src="data:${payment.type};base64,${payment.encoding}">
                            </div>
                        </a>
                        <div class="text">
                            <a href="/guest/product/detail?product_id=${payment.productId}"
                               style="text-decoration: none; color: inherit;">
                                <p style="font-size: small; color: red;">${payment.pgTid}</p>
                                <p style="font-weight: bold;">${payment.productName}</p>
                                <fmt:formatNumber value="${payment.cost}" pattern="#,###"/>원 -->
                                <span style="color: red"><fmt:formatNumber value="${payment.paidAmount}"
                                                                           pattern="#,###"/>원</span>
                            </a>
                        </div>
                        <div class="button-container">
                            <button class="refund-button" data-payment-id="${payment.paymentId}"
                                    style="background-color: red;">환불처리
                            </button>
                            <button class="used-button" data-payment-id="${payment.paymentId}">사용완료처리</button>
                        </div>
                    </div>
                </div>
                <table class="payment-table">
                    <tr>
                        <td class="label">상품 이름</td>
                        <td class="value">${payment.productName}</td>
                    </tr>
                    <tr>
                        <td class="label">결제 코드</td>
                        <td class="value">${payment.pgTid}</td>
                    </tr>
                    <tr>
                        <td class="label">결제 고객</td>
                        <td class="value">${payment.email}</td>
                    </tr>
                    <tr>
                        <td class="label">결제 방법</td>
                        <td class="value">${payment.pgProvider == 'kakaopay' ? '카카오페이' : payment.pgProvider}</td>
                    </tr>
                    <tr>
                        <td class="label">결제 날짜</td>
                        <td class="value">${payment.createDate}</td>
                    </tr>
                    <tr>
                        <td class="label">결제 금액</td>
                        <td class="value"><fmt:formatNumber value="${payment.paidAmount}" pattern="#,###"/> 원</td>
                    </tr>
                    <tr>
                        <td class="label">할인 금액</td>
                        <td class="value"><fmt:formatNumber value="${payment.cost - payment.paidAmount}"
                                                            pattern="#,###"/> 원
                        </td>
                    </tr>
                    <tr>
                        <td class="label">사용 여부</td>
                        <td class="value">사용 가능</td>
                    </tr>
                    <tr>
                        <td class="label">관리자</td>
                        <td class="value">${payment.adminEmail}</td>
                    </tr>
                </table>
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

    /** 환불하기 버튼 클릭 이벤트 */
    $(".refund-button").click(function () {
        if (confirm("환불하시겠습니까?")) {
            var refundReasonNumber = prompt("환불 사유를 번호로 입력해주세요. (필수)\n1. 단순 변심\n2. 더 좋은 상품 발견" +
                "\n3. 환불 후 재결제 예정\n4. 여행 날짜 변경\n5. 기타");

            if (refundReasonNumber !== null && refundReasonNumber !== "") { // 입력하지 않거나 취소 버튼을 누르면 환불 처리를 막음
                if (!isNaN(refundReasonNumber) && refundReasonNumber >= 1 && refundReasonNumber <= 5) { // 1부터 5 사이의 숫자
                    var paymentId = $(this).data("payment-id");
                    $.ajax({
                        url: "/admin/refund/processing",
                        type: "POST",
                        data: {
                            "paymentId": paymentId,
                            "reasonId": refundReasonNumber
                        },
                        success: function (data) {
                            alert("환불 처리했습니다.");
                            location.reload();
                        },
                        error: function (error) {
                            alert("환불 처리에 실패했습니다.");
                        }
                    })
                } else {
                    alert("1부터 5 사이의 번호를 입력해주세요.");
                }
            } else {
                alert("환불 사유를 입력해주세요.");
            }
        }
    });

    /** 사용 완료 처리 버튼 클릭 이벤트 */
    $(".used-button").click(function () {
        if (confirm("사용 완료 처리하시겠습니까?")) {
            var paymentId = $(this).data("payment-id");
            $.ajax({
                url: "/admin/used/processing",
                type: "POST",
                data: {
                    "paymentId": paymentId
                },
                success: function (data) {
                    alert("사용 완료 처리했습니다.");
                    location.reload();
                },
                error: function (error) {
                }
            });
        }
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
