<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%@ include file="../base_view/header.jsp" %>
<c:choose>
    <c:when test="${user.role eq 'ROLE_ADMIN'}">
        <%@ include file="/WEB-INF/views/admin/base_view/navigation.jsp" %>
    </c:when>
    <c:otherwise>
        <%@ include file="../base_view/navigation.jsp" %>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>어디로 여행을 떠날까요?</title>
<style>
    .content {
        margin-left: 18%; /* 네비게이션 바의 넓이와 일치하도록 설정 */
        padding: 20px; /* 적절한 여백 */
        display: flex;
        justify-content: center; /* 가로 중앙 정렬 */
        margin-bottom: 5%;
        overflow-y: auto; /* 네비게이션 바 내용이 화면을 벗어날 경우 스크롤 바 추가 */
    }

    .main-container {
        width: 70%;
        padding: 20px; /* 내부 여백 추가 */
    }

    /* 검색창 컨테이너 스타일 */
    .search-container {
        display: flex;
        justify-content: center; /* 가로 중앙 정렬 */
        width: 100%;
        margin: 3% 0 5% 0;
    }

    /* 검색창 스타일 */
    .search-box {
        margin-top: 5%;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 90%;
    }

    /* 검색 버튼 스타일 */
    .search-button {
        margin-top: 5%;
        padding: 10px 20px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 5px;
        margin-left: 10px;
        cursor: pointer;
    }

    .popular-container {
        margin-bottom: 5%;
    }

    /* 이미지 컨테이너 스타일 */
    .img-container {
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

    .img-text {
        text-align: left; /* 텍스트를 왼쪽 정렬로 설정합니다. */
    }

    .pagination {
        margin-bottom: 8%;
        text-align: center;
        padding-right: 5%;
        margin-top: 3%;
    }

    .pagination .page-item {
        display: inline;
        margin: 0 4px;
    }

    .pagination .page-link {
        padding: 10px 15px;
        border: 1px solid #ddd; /* Optional: Border style */
        background-color: #f8f9fa; /* Optional: Background color */
        color: #333; /* Optional: Text color */
        border-radius: 4px; /* Optional: Rounded corners */
    }

    .pagination .page-link:hover {
        background-color: #333; /* Optional: Hover background color */
        color: #fff; /* Optional: Hover text color */
        border-color: #333; /* Optional: Hover border color */
    }

    .pagination .page-item.active .page-link {
        background-color: #333; /* Optional: Active page background color */
        color: #fff; /* Optional: Active page text color */
        border-color: #333; /* Optional: Active page border color */
    }

    .pagination .page-link:focus {
        outline: none; /* Optional: Remove focus outline */
    }

    /* Optional: Adjust the style of previous and next buttons */
    .pagination .page-item:first-child .page-link {
        border-top-left-radius: 4px;
        border-bottom-left-radius: 4px;
    }

    .pagination .page-item:last-child .page-link {
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="search-container">
            <input type="text" class="search-box" id="searchInput" placeholder="어디로 여행을 떠날까요?">
            <button class="search-button" onclick="search(event)">검색</button>
        </div>
        <div class="travel-container" id="main_search_result">
            <div class="popular-container">
                <h1>최근 뜨는 여행 상품</h1>
                <div class="img-container">
                    <c:forEach var="product" items="${productsTop4}">
                        <a href="../product/detail?product_id=${product.id}"
                           style="text-decoration: none; color: inherit;">
                            <div class="img" style="display: inline-block;">
                                <img src="data:${product.type};base64,${product.encoding}" class="img-fluid">
                                <div class="img-text">
                                    <p style="font-size: small; color: red;">${product.country}
                                        - ${product.city}</p>
                                    <p>${product.name}</p>
                                    <p style="font-weight: normal; font-size: medium;">좋아요 ${product.like}</p>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
            <div class="popular-container">
                <c:forEach var="productsByTag" items="${productsByTags}">
                    <h1>이런 여행지는 어떠세요? #${productsByTag.tag}</h1>
                    <div class="change-container">
                        <div class="img-container">
                            <c:forEach var="product" items="${productsByTag.productDtos}">
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
                                <c:forEach begin="${productsByTag.pagination.startPage + 1}"
                                           end="${productsByTag.pagination.endPage}" varStatus="status">
                                    <li class="page-item">
                                        <a class="page-link"
                                           data-tag-id=${productsByTag.tagId} data-page="${status.index}">${status.index}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
</div>
<script>
    /** 최근 게시글 중 검색 */
    function search(event) {
        event.preventDefault();
        var keyword = document.getElementById('searchInput').value;
        $.ajax({
            type: 'POST',
            url: 'products/search',
            data: {"keyword": keyword},
            success: function (response) {
                $("#main_search_result").html(response);
            },
            error: function (error) {

            }
        });
    }

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
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
