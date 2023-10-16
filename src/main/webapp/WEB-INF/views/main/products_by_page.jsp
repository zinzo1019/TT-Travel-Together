<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../base_view/header.jsp" %>

<div class="img-container">
    <c:forEach var="product" items="${products}">
        <a href="/guest/product/detail?product_id=${product.id}"
           style="text-decoration: none; color: inherit;">
            <div class="img">
                <img src="data:${product.type};base64,${product.encoding}" class="img-fluid">
                <div style="text-align: left;">
                    <p style="font-size: small; color: red;">${product.country}
                        - ${product.city}</p>
                    <p>${product.name}</p>
                    <p style="font-weight: normal; font-size: medium;">좋아요 ${product.like}</p>
                </div>
            </div>
        </a>
    </c:forEach>
</div>
<!-- 페이징 처리 -->
<div>
    <ul class="pagination">
        <c:forEach begin="${pagination.startPage + 1}"
                   end="${pagination.endPage}" varStatus="status">
            <li class="page-item">
                <a class="page-link"
                   data-tag-id=${tagId} data-page="${status.index}">${status.index}</a>
            </li>
        </c:forEach>
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