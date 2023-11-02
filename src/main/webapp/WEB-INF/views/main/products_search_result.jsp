<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ include file="../base_view/header.jsp" %>
<%--콤마 추가--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:choose>
    <c:when test="${user.role eq 'ROLE_ADMIN'}">
        <%@ include file="/WEB-INF/views/admin/base_view/navigation.jsp" %>
    </c:when>
    <c:otherwise>
        <%@ include file="../base_view/navigation.jsp" %>
    </c:otherwise>
</c:choose>

<h1>아래 여행지를 찾으시나요?</h1>
<c:forEach var="product" items="${products}">
    <div class="img-container">
        <a href="/guest/product/detail?product_id=${product.travelProductId}" style="text-decoration: none; color: inherit;">
            <div class="img product-img-container">
                <img src="data:${product.type};base64,${product.encoding}" class="product-img">
                <div class="like-info">
                        <%-- 로그인 상태 --%>
                    <c:if test="${not empty pageContext.request.userPrincipal }">
                        <img src="${product.userLiked ? '/images/like.png' : '/images/empty-like.png'}" class="like-img">
                    </c:if>
                        <%-- 로그아웃 상태 --%>
                    <c:if test="${empty pageContext.request.userPrincipal }">
                        <img src='/images/empty-like.png' class="like-img">
                    </c:if>
                </div>
            </div>
        </a>
        <div class="text">
            <a href="/guest/product/detail?product_id=${product.travelProductId}"
               style="text-decoration: none; color: inherit;">
                <div style="">
                    <div class="tag-div" style="font-size: small; color: red;">
                        <c:forEach var="tag" items="${product.tags}" varStatus="status">
                            # ${tag.tag}&nbsp;&nbsp;
                        </c:forEach>
                    </div>
                    <p>${product.name}</p>
                    <p>${product.descriptions}</p>
                </div>
            </a>
            <div class="cost-container">
                <p style="padding-right: 1%;"><fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원</p>
            </div>
            <p class="like-text">${product.like}명이 좋아하고 있어요!</p>
        </div>
    </div>
    <br><br>
</c:forEach>