<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="popular-container">
    <h1>아래 여행지를 찾으시나요?</h1>
    <div class="change-container">
        <div class="img-container" style="height: 350px;">
            <c:forEach var="product" items="${products.content}">
                <a href="/guest/product/detail?product_id=${product.id}" class="shadowed"
                   style="flex: 0.235;">
                    <div class="product-img" style="display: inline-block;">
                        <img src="data:${product.type};base64,${product.encoding}">
                        <div class="product-info">
                            <p style="font-size: small; color: red; margin-bottom: 0;">${product.country}
                                - ${product.city}</p>
                            <p style="margin-top: 0; font-weight: bold;">${product.name}</p>
                            <p style="font-weight: normal; font-size: medium; margin-bottom: 1px">
                            <div class="like-container">
                                <fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원
                                <span style="opacity: 0.6;">/ 1인</span>
                                    <%--                                        <img src='/images/like.png' class="like-img"--%>
                                    <%--                                             style="width: 20px; height: 20px; vertical-align: middle; padding-top: 5px;">--%>
                                    <%--                                        <span style="display: inline-block; vertical-align: middle;">--%>
                                    <%--                                                ${product.like}--%>
                                    <%--                                        </span>--%>
                            </div>
                            </p>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
        <!-- 페이징 처리 -->
        <div>
            <ul class="product-pagination pagination">
                <c:forEach begin="1" end="${products.totalPages}" varStatus="status">
                    <li class="page-item">
                        <a class="page-link" data-page="${status.index}">${status.index}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>