<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<title>이 여행지에 관심있어요.</title>
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
        font-size: large;
        font-weight: bold;
    }

    .tag-div {
        flex: 2; /* 텍스트 영역이 이미지보다 더 넓게 설정 */
        align-self: flex-start; /* 텍스트를 세로로 맨 위에 정렬 */
        padding-top: 1%;
        font-size: medium;
    }

    .img img {
        width: 200px;
        height: 200px;
    }

    .like-img {
        width: 20px;
        height: 20px;
        margin-top: 5%;
        margin-right: 2%;
    }

    .like-container {
        display: flex;
        align-items: center; /* 세로 중앙 정렬 */
        height: 0;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="travel-container" id="products_search_result">
            <h1>${user.name}님이 좋아한 ${fn:length(products)}건의 여행 상품이 있어요.</h1>
            <c:forEach var="product" items="${products}">
                <div class="img-container">
                    <a href="/ROLE_GUEST/product/detail?product_id=${product.id}"
                       style="text-decoration: none; color: inherit;">
                        <div class="img" style="display: inline-block;">
                            <img src="data:${product.type};base64,${product.encoding}" class="img-fluid">
                        </div>
                    </a>
                    <div class="text">
                        <a href="/ROLE_GUEST/product/detail?product_id=${product.id}"
                           style="text-decoration: none; color: inherit;">
                            [${product.country} - ${product.city}] ${product.name}${product.descriptions}
                            <br><br>
                            <fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원
                        </a>
                        <div class="tag-div">
                            <c:forEach var="tag" items="${product.tags}" varStatus="status">
                                # ${tag.tag}&nbsp;&nbsp;
                            </c:forEach>
                        </div>
                        <div class="like-container">
                                <%--    로그인 상태--%>
                            <c:if test="${not empty pageContext.request.userPrincipal }">
                                <img src="${product.userLiked ? '/images/like.png' : '/images/empty-like.png'}" class="like-img">
                                <p style="font-size: medium; margin-top: 5%">${product.like}</p>
                            </c:if>
                                <%--    로그아웃 상태--%>
                            <c:if test="${empty pageContext.request.userPrincipal }">
                                <img src='/images/empty-like.png' class="like-img">
                                <p style="font-size: medium; margin-top: 5%">${product.like}</p>
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
