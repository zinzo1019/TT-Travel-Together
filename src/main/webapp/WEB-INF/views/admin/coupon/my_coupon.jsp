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
<title>내 쿠폰 보기</title>
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

    .coupon-container {
        position: relative;
        margin-bottom: 3%;
        background-color: #f0f0f0; /* 원하는 배경 색상으로 설정 */
        padding: 20px; /* 내부 여백 추가 */
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
    }

    .edit-button {
        position: absolute;
        top: 20px;
        right: 20px;
    }

    .delete-button {
        padding: 7px 15px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 13px;
    }

    .modify-button {
        padding: 7px 15px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 13px;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="search-container">
            <input type="text" class="search-box" id="searchInput" placeholder="어떤 쿠폰을 찾으세요?">
            <button class="search-button" onclick="search(event)">검색</button>
        </div>
        <div class="travel-container" id="coupon_search_result">
            <h1 style="margin-top: 5%">${user.name}님이 등록한 ${fn:length(coupons)}건의 쿠폰이예요.</h1>
            <c:forEach var="coupon" items="${coupons}">
                <div class="coupon-container">
                    <p style="font-size: small; color: red">
                        [${coupon.country} - ${coupon.city}] ${coupon.productName}
                    </p>
                    <div>
                        <p style="font-size: large; font-weight: bold; margin-bottom: 1%">
                                ${coupon.name}
                        </p>
                        <p style="font-size: medium; margin-bottom: 2%;">${coupon.description}</p>
                        <p class="discount">
                            <c:choose>
                                <c:when test="${coupon.amount > 0}">
                                    <strong>할인 금액:</strong> ${coupon.amount} 할인
                                </c:when>
                                <c:when test="${coupon.percentage > 0}">
                                    <strong>할인 퍼센트:</strong> ${coupon.percentage}% 할인
                                </c:when>
                                <c:otherwise>
                                    <strong>할인 없음</strong>
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <p style="font-size: medium"><strong>쿠폰 코드: </strong>${coupon.code}</p>
                    </div>
                    <div class="edit-button">
                        <button class="modify-button" data-coupon-id="${coupon.couponId}">수정</button>
                        <button class="delete-button" data-coupon-id="${coupon.couponId}">삭제</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<script>
    /** 쿠폰 검색 */
    function search(event) {
        event.preventDefault();
        var keyword = document.getElementById('searchInput').value;
        $.ajax({
            type: 'POST',
            url: 'my/search',
            data: {"keyword": keyword},
            success: function (response) {
                $("#coupon_search_result").html(response);
            },
            error: function (error) {
            }
        });
    }

    /** 쿠폰 수정 혹은 삭제 버튼 클릭 */
    $(document).ready(function() {
        // 수정 버튼 클릭 이벤트 핸들러
        $(document).ready(function() {
            $(".modify-button").click(function() {
                var couponId = $(this).data("coupon-id"); // 데이터 속성에서 쿠폰 ID를 가져옵니다.
                window.location.href = "update?coupon_id=" + couponId;
            });
        });

        // 삭제 버튼 클릭 이벤트 핸들러
        $(".delete-button").click(function() {
            var couponId = $(this).data("coupon-id");
            $.ajax({
                type: "POST",
                url: "delete?coupon_id=" + couponId,
                success: function(data) {
                    alert("쿠폰을 삭제했습니다.");
                    window.location.reload();
                },
                error: function() {
                    alert("쿠폰 삭제에 실패했습니다.");
                }
            });
        });
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
