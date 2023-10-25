<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    /* 네비게이션 바 스타일 */
    nav {
        position: fixed;
        top: 50px; /* 헤더의 높이만큼 여백 추가 */
        left: 0;
        width: 18%; /* 화면 너비의 18%로 설정 */
        height: 100%; /* 화면 전체 높이에 맞추세요. */
        background-color: #333;
        color: white;
        max-height: 800px; /* 원하는 높이로 설정합니다. */
        overflow-y: scroll; /* 세로 스크롤을 추가합니다. */
        scrollbar-width: thin; /* 스크롤 바의 두께 설정 */
        scrollbar-color: transparent transparent; /* 스크롤 바 색상 설정 */
    }

    /* 스크롤 바 숨김 스타일 */
    nav::-webkit-scrollbar {
        width: 6px; /* 스크롤 바의 너비 설정 */
    }

    nav::-webkit-scrollbar-thumb {
        background-color: transparent; /* 스크롤 바의 색상을 투명으로 설정하여 숨깁니다. */
    }

    nav ul {
        list-style-type: none;
        margin: 0;
        margin-top: 15%;
        padding: 0;
        padding-bottom: 70px;
    }

    nav ul li {
        margin: 10px 0;
    }

    nav ul li a {
        display: block;
        text-decoration: none;
        color: white;
        font-weight: bold;
        padding: 10px;
    }

    /* 네비게이션 바 hover 스타일 */
    nav ul li a:hover {
        background-color: #555;
    }

    .child-title {
        margin-left: 10%;
        padding: 5px;
    }

    .parent-board {
        padding: 10px;
        font-weight: bold;
    }
</style>
<nav>
    <ul>
        <li class="parent-board">여행 상품 관리</li>
        <li><a href="/admin/my-travel-places" class="child-title">내가 등록한 여행 상품</a></li>
        <li><a href="/admin/my-travel-places/save" class="child-title">여행 상품 등록하기</a></li>

        <li class="parent-board">쿠폰 관리</li>
        <li><a href="/admin/coupon/all" class="child-title">모든 쿠폰</a></li>
        <li><a href="/admin/coupon/my" class="child-title">내가 등록한 쿠폰</a></li>
        <li><a href="/admin/coupon/save" class="child-title">쿠폰 등록하기</a></li>

        <li class="parent-board">결제 관리</li>
        <li><a href="/admin/payment/view" class="child-title">결제 관리</a></li>
        <li><a href="/admin/statistics/payment" class="child-title">결제 통계</a></li>

        <li class="parent-board">환불 관리</li>
        <li><a href="/admin/refund/view" class="child-title">환불 관리</a></li>
        <li><a href="/admin/statistics/refund" class="child-title">환불 통계</a></li>

        <%--    로그인 상태--%>
        <c:if test="${not empty pageContext.request.userPrincipal }">
            <li class="parent-board"><a href="/logout">로그아웃</a></li>
        </c:if>
    </ul>
</nav>
<script>
</script>