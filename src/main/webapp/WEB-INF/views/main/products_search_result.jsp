<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<%--콤마 추가--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h1>아래 여행지를 찾으시나요?</h1>
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
                [${country.city}] ${product.name}${product.descriptions}
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

