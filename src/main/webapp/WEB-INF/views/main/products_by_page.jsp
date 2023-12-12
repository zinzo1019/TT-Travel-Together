<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../base_view/header.jsp" %>

<div class="img-container" style="height: 350px;">
    <c:forEach var="product" items="${products.content}">
        <a href="/guest/product/detail?product_id=${product.travelProductId}" class="shadowed" style="flex: 0.25;">
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
                    </div>
                    </p>
                </div>
            </div>
        </a>
    </c:forEach>
</div>
<!-- 페이징 처리 -->
<div>
                        <ul class="pagination">
                        <c:choose>
                            <c:when test="${products.totalPages > 0}">
        <c:forEach begin="1" end="${products.totalPages}" varStatus="status">
            <li class="page-item">
                <a class="page-link"
                   data-tag-id=${tagId} data-page="${status.index}">${status.index}</a>
            </li>
        </c:forEach>
                            </c:when>
                        </c:choose>
    </ul>
</div>
<script>
    /** 개별 페이징 처리 */
    $(document).ready(function () {
        $(".pagination").on("click", ".page-link", function (event) { // 페이지 클릭 시
            event.preventDefault();
            var page = $(this).data("page"); // 페이지
            var tagId = $(this).data("tag-id"); // 태그 아이디

            // pagination 클래스의 부모 중 change-container 클래스 선택
            var container = $(this).parents(".change-container");
            $.ajax({
                type: "post",
                url: "/guest/loadPagedData",
                data: {
                    tagId: tagId,
                    page: page
                },
                success: function (response) {
                    container.html(response); // 검색 결과
                },
                error: function (error) {
                }
            });
        });
    });
</script>