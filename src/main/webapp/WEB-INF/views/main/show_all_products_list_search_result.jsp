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
<style>
    .search-img-container {
        width: 100%;
        display: flex;
        overflow: hidden;
        align-items: center;
        border-radius: 15px;
    }

    .search-img {
        display: inline-block;
        float: left; /* 이미지를 왼쪽으로 띄움 */
        margin-right: 20px; /* 이미지 사이의 간격 설정 */
        flex: 1; /* 이미지가 늘어날 수 있도록 flex 속성을 설정 */
        padding-right: 20px; /* 이미지와 텍스트 사이의 간격 설정 */
        border-radius: 15px 0 0 15px;
    }

    .search-img img {
        width: 180px;
        height: 180px;
    }

    .search-text {
        flex: 2; /* 텍스트 영역이 이미지보다 더 넓게 설정 */
        align-self: flex-start; /* 텍스트를 세로로 맨 위에 정렬 */
        font-size: large;
        font-weight: bold;
        padding: 3% 3% 3% 0;
    }

    .tag-div {
        flex: 2; /* 텍스트 영역이 이미지보다 더 넓게 설정 */
        align-self: flex-start; /* 텍스트를 세로로 맨 위에 정렬 */
        font-size: medium;
    }

    .like-img {
        width: 20px;
        height: 20px;
        margin-top: 5%;
        margin-right: 2%;
    }

    .like-container {
        display: flex;
        justify-content: flex-start; /* 좌측 정렬 */
        align-items: center; /* 요소들을 수직 가운데로 정렬 */
        padding: 8px 0; /* 위아래 패딩 추가 */
        position: absolute;
        bottom: 0;
    }
</style>
<h1>"${keyword}"에 대한 ${fn:length(products)}건의 여행지가 있어요!</h1>
<c:forEach var="product" items="${products}">
    <div class="search-img-container">
        <a href="/guest/product/detail?product_id=${product.id}"
           style="text-decoration: none; color: inherit;">
            <div class="search-img">
                <img src="data:${product.type};base64,${product.encoding}">
            </div>
        </a>
        <div class="search-text">
            <a href="/guest/product/detail?product_id=${product.id}"
               style="text-decoration: none; color: inherit;">
                <p style="font-size: small; color: red;">${product.country} - ${product.city}</p>
                <p style="margin-bottom: 2%; font-size: large; font-weight: bold;">${product.name}${product.descriptions}</p>
                <fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원
            </a>
            <div class="tag-div" style="margin-top: 2%">
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
