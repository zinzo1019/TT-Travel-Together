<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="img-container" style="height: 350px;">
    <c:forEach var="product" items="${products.content}">
        <a href="guest/product/detail?product_id=${product.travelProductId}" class="shadowed">
            <div class="product-img" style="display: inline-block;">
                <img src="data:${product.type};base64,${product.encoding}" class="img-fluid">
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
    <ul class="product-pagination pagination">
        <c:choose>
            <c:when test="${products.totalPages > 0}">
                <c:forEach begin="1" end="${products.totalPages}" varStatus="status">
                    <li class="page-item">
                        <a class="page-link" data-page="${status.index}">${status.index}</a>
                    </li>
                </c:forEach>
            </c:when>
        </c:choose>
    </ul>
</div>
<script>
    /** 개별 페이징 처리 */
    $(document).ready(function () {
        $(".product-pagination").on("click", ".page-link", function (event) { // 페이지 클릭 시
            event.preventDefault();
            var page = $(this).data("page"); // 페이지
            var tag = "힐링"// 태그

            if ("${user.travelTag}" != "") {
                tag = "${user.travelTag}"
            }

            // pagination 클래스의 부모 중 change-container 클래스 선택
            var container = $(this).parents(".change-container");
            $.ajax({
                type: "post",
                url: "/guest/product/pagination",
                data: {
                    tag: tag,
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
