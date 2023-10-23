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
        flex: 0.22; /* 1/4(25%)의 가로 공간을 갖도록 설정합니다. */
        height: 320px;
    }

    .img {
        flex: 1;
        margin-bottom: 10px;
        position: relative;
    }

    .img img {
        width: 100%;
        height: 320px;
        border-radius: 10px;
    }

    .img-container {
        display: flex;
        gap: 30px;
        justify-content: flex-start; /* 왼쪽 정렬 (기본값) */
    }

    .img p {
        font-size: large;
        font-weight: bold;
    }

    .img-text {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        color: white; /* 텍스트 색상 설정 */
        padding: 10px; /* 텍스트 패딩 설정 */
        box-sizing: border-box;
    }
</style>
<h1>이 여행지를 찾으셨나요?</h1>
<div class="img-container">
    <c:forEach var="country" items="${searchResults.content}">
        <a href="/guest/country?country_id=${country.countryId}"
           style="text-decoration: none; color: inherit;">
            <div class="img">
                <img src="${country.image}">
                <div class="img-text">
                    <p>${country.country} - ${country.city}</p>
                    <p style="font-weight: normal; font-size: medium;">
                        <img src='/images/like.png' class="like-img" style="width: 20px; height: 20px; vertical-align: middle; padding-top: 5px;">
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
<ul class="pagination">
    <c:forEach begin="1" end="${pagination.endPage}" varStatus="status">
        <li class="page-item">
            <a class="page-link" href="?page=${status.index}">${status.index}</a>
        </li>
    </c:forEach>
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