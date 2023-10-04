<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ include file="../base_view/header.jsp" %>
<%@ include file="../base_view/navigation.jsp" %>
<%--콤마 추가--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h1>아래 여행지를 찾으시나요?</h1>
<c:forEach var="product" items="${products}">
    <div class="img-container">
        <a href="/ROLE_GUEST/product/detail?product_id=${product.id}"
           style="text-decoration: none; color: inherit;">
            <div class="img" style="display: inline-block;">
                <img src="${product.image}">
            </div>
        </a>
        <div class="text">
            <a href="/ROLE_GUEST/product/detail?product_id=${product.id}"
               style="text-decoration: none; color: inherit;">
                [${country.city}] ${product.name}${product.descriptions}
                <br><br>
                <fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원
            </a><br><br>
            <div class="tag-div">
                <c:forEach var="tag" items="${product.tags}" varStatus="status">
                    # ${tag.tag}&nbsp;&nbsp;
                </c:forEach>
            </div>
        </div>
    </div>
    <br><br>
</c:forEach>

