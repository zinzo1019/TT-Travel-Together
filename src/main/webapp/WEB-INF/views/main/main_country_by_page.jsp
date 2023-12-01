<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="img-container">
    <c:forEach var="country" items="${countries.content}">
        <a href="/guest/country?country_id=${country.countryId}" class="shadowed">
            <div class="img">
                <img src="${country.image}">
                <div class="img-text">
                    <p>${country.country} - ${country.city}</p>
                    <p style="font-weight: normal; font-size: medium;">
                        <img src='/images/like.png' class="like-img"
                             style="width: 20px; height: 20px; vertical-align: middle; padding-top: 5px;">
                        <span style="display: inline-block; vertical-align: middle;">
                                ${country.totalLikes}
                        </span>
                    </p>
                </div>
            </div>
        </a>
    </c:forEach>
</div>

<!-- 페이징 처리 -->
<ul class="country-pagination pagination">
    <c:forEach begin="1" end="${countries.totalPages-1}" varStatus="status">
        <li class="page-item">
            <a class="page-link" data-page="${status.index}">${status.index}</a>
        </li>
    </c:forEach>
</ul>
</div>
<script>
    /** 여행 상품 페이징 처리 */
    $(document).ready(function () {
        $(".country-pagination").on("click", ".page-link", function (event) { // 페이지 클릭 시
            event.preventDefault();
            var page = $(this).data("page"); // 페이지

            // pagination 클래스의 부모 중 change-container 클래스 선택
            var container = $(this).parents(".change-container");
            $.ajax({
                type: "post",
                url: "/guest/country/pagination",
                data: {
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