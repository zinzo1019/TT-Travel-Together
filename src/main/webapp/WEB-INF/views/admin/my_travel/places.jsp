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
<title>관리자가 등록한 여행지 리스트</title>
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
        margin-top: 3%;
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
        padding-top: 1%;
        font-size: large;
        font-weight: bold;
    }

    .img img {
        width: 200px;
        height: 200px;
    }

    .like-img {
        width: 20px;
        height: 20px;
        padding-right: 1%;
    }

    .like-container {
        display: flex;
        align-items: center; /* 세로 중앙 정렬 */
        margin-top: 1%;
        height: 35px;
    }

    .button-container {
        margin-top: 1%;
    }

    .search-button {
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
        <div class="travel-container" id="products_search_result">
            <h1 style="margin-top: 5%">${user.name}님이 등록한 ${fn:length(products)}건의 여행 상품이예요.</h1>
            <c:forEach var="product" items="${products}">
                <div class="img-container">
                    <a href="/guest/product/detail?product_id=${product.travelProductId}"
                       style="text-decoration: none; color: inherit;">
                        <div class="img" style="display: inline-block;">
                            <img src="data:${product.type};base64,${product.encoding}" style="border-radius: 15px;">
                        </div>
                    </a>
                    <div class="text">
                        <a href="/guest/product/detail?product_id=${product.travelProductId}"
                           style="text-decoration: none; color: inherit;">
                            <c:choose>
                                <c:when test="${!product.enabled}">
                                    <p style="font-size: small; color: red;" data-product-id="${product.travelProductId}">* 현재 판매 중지된 상품입니다.</p>
                                </c:when>
                                <c:otherwise>
                                    <p style="font-size: small; color: blue;" data-product-id="${product.travelProductId}">* 현재 판매 중인 상품입니다.</p>
                                </c:otherwise>
                            </c:choose>
                            <p style="margin-bottom: 2%">
                                [${product.city}] ${product.name}${product.descriptions}</p>
                            <p><fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원</p>
                        </a>
                        <div class="tag-div">
                            <c:forEach var="tag" items="${product.tags}" varStatus="status">
                                # ${tag.tag}&nbsp;&nbsp;
                            </c:forEach>
                        </div>
<%--                        <div class="like-container">--%>
<%--                                &lt;%&ndash; 로그인 상태 &ndash;%&gt;--%>
<%--                            <c:if test="${not empty pageContext.request.userPrincipal}">--%>
<%--                                <img src="${product.userLiked ? '/images/like.png' : '/images/empty-like.png'}"--%>
<%--                                     class="like-img">--%>
<%--                                <p>${product.like}</p>--%>
<%--                            </c:if>--%>
<%--                                &lt;%&ndash; 로그아웃 상태 &ndash;%&gt;--%>
<%--                            <c:if test="${empty pageContext.request.userPrincipal}">--%>
<%--                                <img src='/images/empty-like.png' class="like-img">--%>
<%--                                <p>${product.like}</p>--%>
<%--                            </c:if>--%>
<%--                        </div>--%>
                        <div class="button-container">
                                <%-- 수정하기 버튼 --%>
                            <c:if test="${not empty pageContext.request.userPrincipal }">
                                <button class="search-button modifyButton" data-product-id="${product.travelProductId}">수정하기
                                </button>
                            </c:if>
                            <c:choose>
                                <c:when test="${product.enabled}">
                                    <button class="search-button stopButton" data-product-id="${product.travelProductId}" style="background-color: red">판매중지</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="search-button sellButton" data-product-id="${product.travelProductId}" style="background-color: blue">판매재개</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <br><br>
            </c:forEach>
        </div>
    </div>
</div>
<script>
    // 수정하기 버튼 클릭 이벤트
    $(".modifyButton").click(function () {
        var productId = $(this).data("product-id");
        window.location.href = "my-travel-places/modify?product_id=" + productId;
    });

    // 판매 중지 버튼 클릭 이벤트
    $(".stopButton").click(function () {
        var productId = $(this).data("product-id");
        $.ajax({
            url: "my-travel-places/enabled/false?product_id=" + productId,
            type: "POST",
            success: function (data) {
                alert("판매를 중지했습니다.");
                location.reload();
            },
            error: function (error) {
                alert("판매 중지에 실패했습니다.");
            }
        });
    });

    // 판매 재개 버튼 클릭 이벤트
    $(".sellButton").click(function () {
        var productId = $(this).data("product-id");
        $.ajax({
            url: "my-travel-places/enabled/true?product_id=" + productId,
            type: "POST",
            success: function (data) {
                alert("판매를 재개했습니다.");
                location.reload();
            },
            error: function (error) {
                alert("판매 재개에 실패했습니다.");
            }
        });
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
