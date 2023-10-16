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
<style>
    .img-container {
        flex-wrap: wrap; /* 이미지들이 넘치면 줄 바꿈합니다. */
        display: flex;
    }

    .img-container a {
        flex: 0.25; /* 1/4(25%)의 가로 공간을 갖도록 설정합니다. */
        text-align: center; /* 이미지 가운데 정렬을 위한 설정입니다. */
        height: 300px;
    }

    .img, .img img {
        width: 100%; /* 이미지를 컨테이너에 맞게 조절합니다. */
        height: 200px;
    }

    .img-container {
        display: flex;
        gap: 20px;
        justify-content: flex-start; /* 왼쪽 정렬 (기본값) */
    }

    .img p {
        font-size: large;
        font-weight: bold;
        margin: 1% 0;
    }
</style>
<h1>이 여행지를 찾으셨나요?</h1>
<div class="img-container">
    <c:forEach var="country" items="${searchResults.content}">
        <a href="/guest/country?country_id=${country.countryId}"
           style="text-decoration: none; color: inherit;">
            <div class="img" style="display: inline-block; margin-right: 20px;">
                <img src="${country.image}">
                <div style="text-align: left">
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
<script>
    /** 최근 게시글 중 검색 */
    function search(event) {
        event.preventDefault();
        var keyword = document.getElementById('searchInput').value;
        $.ajax({
            type: 'POST',
            url: '/guest/search',
            data: {"keyword": keyword}, // 서버에 전달할 데이터
            success: function (response) {
                $("#main_search_result").html(response);
            },
            error: function (error) {

            }
        });
    }
</script>