<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../base_view/header.jsp" %>
<c:choose>
    <c:when test="${user.role eq 'ROLE_ADMIN'}">
        <%@ include file="/WEB-INF/views/admin/base_view/navigation.jsp" %>
    </c:when>
    <c:otherwise>
        <%@ include file="../base_view/navigation.jsp" %>
    </c:otherwise>
</c:choose>

<h1>이 여행지를 찾으셨나요?</h1>
<div class="img-container">
    <c:forEach var="country" items="${searchResults.content}">
        <a href="/ROLE_GUEST/country?country_id=${country.countryId}"
           style="text-decoration: none; color: inherit;">
            <div class="img" style="display: inline-block; margin-right: 20px;">
                <img src="${country.image}">
                <div>
                    <p>${country.country} - ${country.city}</p>
                    <p style="font-weight: normal; font-size: medium">좋아요 ${country.totalLikes}</p>
                </div>
            </div>
        </a>
    </c:forEach>
</div>
<!-- 페이징 처리 -->
<ul class="pagination">
    <li class="page-item">
        <a class="page-link" href="#" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
        </a>
    </li>
    <c:forEach begin="1" end="${pagination.endPage}" varStatus="status">
        <li class="page-item">
            <a class="page-link" href="?page=${status.index}">${status.index}</a>
        </li>
    </c:forEach>
    <li class="page-item">
        <a class="page-link" href="#" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
        </a>
    </li>
</ul>