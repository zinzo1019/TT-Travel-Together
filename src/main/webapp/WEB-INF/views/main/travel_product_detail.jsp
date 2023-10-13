<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--콤마 추가--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
<title>어느 상품이 좋으세요?</title>
<style>
    .content {
        margin-left: 18%; /* 네비게이션 바의 넓이와 일치하도록 설정 */
        padding: 20px; /* 적절한 여백 */
        justify-content: center; /* 가로 중앙 정렬 */
        margin-bottom: 5%;
        overflow-y: auto; /* 네비게이션 바 내용이 화면을 벗어날 경우 스크롤 바 추가 */
    }

    .main-container {
        width: 70%;
        padding: 20px; /* 내부 여백 추가 */
        margin: 0 auto;
    }

    /* 검색창 컨테이너 스타일 */
    .travel-container {
        margin-top: 5%;
        margin-left: 1%;
    }

    .img-container {
        width: 100%;
        overflow: hidden; /* 넘치는 내용을 가리기 위해 */
        display: flex; /* Flexbox 레이아웃 사용 */
        align-items: center; /* 수직 가운데 정렬 */
    }

    .img {
        float: left; /* 이미지를 왼쪽으로 띄움 */
        margin-right: 20px; /* 이미지 사이의 간격 설정 */
        flex: 1; /* 이미지가 늘어날 수 있도록 flex 속성을 설정 */
        padding-right: 20px; /* 이미지와 텍스트 사이의 간격 설정 */
    }

    .text {
        flex: 2; /* 텍스트 영역이 이미지보다 더 넓게 설정 */
        align-self: flex-start; /* 텍스트를 세로로 맨 위에 정렬 */
        padding-top: 1%;
        font-size: x-large;
        font-weight: bold;
    }

    .like-img {
        width: 20px;
        height: 20px;
    }

    .no-style {
        text-decoration: none;
        border: none;
        background: none;
        padding: 0;
        margin: 0;
        color: inherit;
    }

    .tag-div {
        flex: 2; /* 텍스트 영역이 이미지보다 더 넓게 설정 */
        align-self: flex-start; /* 텍스트를 세로로 맨 위에 정렬 */
        padding-top: 4%;
        font-size: medium;
    }

    .img img {
        width: 400px;
        height: 400px;
    }

    .coupon-form {
        margin: 3% 0;
        width: 81%;
    }

    /* 스타일을 travel_product tp할 드롭다운 쿠폰 선택 요소 */
    .coupon-form select {
        width: 80%;
        background-color: #f2f2f2;
        color: #333;
        border: 1px solid #ccc;
        padding: 10px;
        border-radius: 5px;
        transition: background-color 0.3s, color 0.3s;
    }

    /* 드롭다운에서 항목을 선택할 때 색상 변경 */
    .coupon-form select:focus {
        background-color: #fff;
        color: #555;
    }

    /* 드롭다운 화살표 아이콘을 가운데 정렬 */
    .coupon-form select::-ms-expand {
        display: none; /* IE에서 화살표 아이콘 숨김 */
    }

    /* 드롭다운 화살표 아이콘 스타일링 */
    .coupon-form select::after {
        content: '▼';
        font-size: 16px;
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        pointer-events: none;
    }

    .coupon-list li {
        padding: 5px;
        cursor: pointer;
    }

    .coupon-list li:hover {
        background-color: #f0f0f0;
    }

    button {
        padding: 10px 20px;
        background-color: #007BFF;
        color: #fff;
        border: none;
        border-radius: 3px;
        cursor: pointer;
    }

    .result {
        display: none;
        margin-top: 20px;
        padding: 10px;
        background-color: #e5f9e5;
        border: 1px solid #00a74a;
        border-radius: 3px;
    }

    #coupon-message {
        color: #00a74a;
    }

    .comment-list {
        list-style: none;
        padding: 0;
    }

    .comment {
        margin-bottom: 10px;
        border-radius: 10px; /* 모서리 둥글게 만들기 */
    }

    .comment-form textarea {
        width: 100%;
        padding: 15px;
        border: 1px solid #ddd;
        margin-bottom: 10px;
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
        resize: none; /* 크기 조절 비활성화 */
    }

    .submit-comment-button {
        padding: 10px 20px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        float: right;
        margin: 1% 0;
    }

    .checkoutButton {
        padding: 10px 20px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        display: inline-block;
        vertical-align: top;
        float: right;
        margin-right: 14%;
    }

    .background-container {
        background-color: #f0f0f0; /* 원하는 배경 색상으로 설정 */
        padding: 20px; /* 내부 여백 추가 */
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        margin-bottom: 5%;
    }

    /* 대댓글 입력 칸 스타일 (기본적으로 숨김) */
    .reply-form {
        display: none;
        margin-top: 10px;
        padding-bottom: 7%;
    }

    .reply-textarea {
        width: 100%;
        padding: 15px;
        border: 1px solid #ddd;
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
        resize: none; /* 크기 조절 비활성화 */
        margin-top: 2%;
        margin-bottom: 1%;
    }

    /* 게시글 스타일 */
    .post {
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px; /* 모서리 둥글게 만들기 */
    }

    /** 답글 달기 & 삭제 버튼 */
    .post button {
        background: none; /* 배경 없애기 */
        border: none;
        padding: 0;
        color: #3f3f3f;
    }

    .post h2 {
        font-size: 24px;
        margin-bottom: 10px;
    }

    .post p {
        font-size: 16px;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="travel-container">
            <div class="img-container">
                <div class="img" style="display: inline-block;">
                    <img src="data:${product.type};base64,${product.encoding}" class="img-fluid">
                </div>
                <div class="text">
                    <div>
                        <%--    로그인 상태--%>
                        <c:if test="${not empty pageContext.request.userPrincipal }">
                            <a href="#" class="no-style" id="like-link">
                                <img src="${product.userLiked ? '/images/like.png' : '/images/empty-like.png'}"
                                     class="like-img">
                            </a>
                            ${product.like}
                        </c:if>
                        <%--    로그아웃 상태--%>
                        <c:if test="${empty pageContext.request.userPrincipal }">
                            <a href="#" class="no-style" id="like-link">
                                <img src='/images/empty-like.png' class="like-img">
                            </a>
                            ${product.like}
                        </c:if>
                    </div>
                    <p style="margin: 3% 0">[${product.country}
                        - ${product.city}] ${product.name}${product.descriptions}</p>
                    <fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원
                    <!-- 쿠폰 창 -->
                    <div class="coupon-form">
                        <div class="form-group">
                            <select class="form-control" id="coupons" name="coupons">
                                <option value="0">선택 없음</option>
                                <c:forEach items="${product.coupons}" var="coupon">
                                    <option value="${coupon.id}">
                                            ${coupon.name} -
                                        <c:choose>
                                            <c:when test="${coupon.percentage > 0}">
                                                ${coupon.percentage}% 할인
                                            </c:when>
                                            <c:otherwise>
                                                ${coupon.amount} 원 할인
                                            </c:otherwise>
                                        </c:choose>
                                    </option>
                                </c:forEach>
                            </select>
                            <button class="submit-comment-button" id="couponButton" style="margin: 0">적용</button>
                        </div>
                    </div>
                    <div class="result">
                        <p id="coupon-message"></p>
                    </div>
                    <div>
                        <p id="updatedCost" style="display: inline-block; vertical-align: top;"><fmt:formatNumber
                                value="${updatedCost}" pattern="#,###"/> 원</p>
                        <button class="checkoutButton" id="CheckoutButton">결제하기</button>
                    </div>
                    <div style="margin-top: 3%">
                        <p style="font-size: medium">${product.description}</p>
                    </div>
                    <div class="tag-div">
                        <c:forEach var="tag" items="${product.tags}" varStatus="status">
                            # ${tag.tag}&nbsp;&nbsp;
                        </c:forEach>
                    </div>
                </div>
            </div>
            <br><br>
        </div>
        <h3>${fn:length(comments)}개의 답변이 있어요.</h3>
        <div class="background-container">
            <div class="comment-form" style="padding-bottom: 7%">
                <textarea placeholder="댓글을 입력하세요" id="commentText"></textarea>
                <button class="submit-comment-button" id="submitButton">댓글 작성</button>
            </div>
            <ul class="comment-list">
                <c:forEach var="comment" items="${comments}">
                    <li class="comment" style="padding-left: ${(comment.level -1) * 30}px">
                        <div class="post">
                            <p style="font-size: small; font-weight: bold;">${comment.userName}</p>
                            <p>${comment.content}</p>
                            <button class="reply-button" style="margin-top: 0%">답글 달기</button>
                            <c:choose>
                                <c:when test="${comment.userId eq user.id}">
                                    <button class="reply-button delete-button" style="margin-top: 0%; color: red;"
                                            data-comment-id="${comment.id}">삭제
                                    </button>
                                </c:when>
                            </c:choose>
                        </div>
                        <!-- 대댓글 입력 칸 (초기에는 숨김) -->
                        <div class="reply-form" style="display: none;">
                            <textarea class="reply-textarea" placeholder="대댓글을 입력하세요"></textarea>
                            <button class="submit-reply-button submit-comment-button" data-comment-id="${comment.id}">
                                대댓글 작성
                            </button>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {
        var updatedCost = ${product.cost}; // 할인가
        var formattedCost = new Intl.NumberFormat('ko-KR', {
            style: 'currency',
            currency: 'KRW'
        }).format(updatedCost);
        $('#updatedCost').html(formattedCost.replace('₩', '') + '원');
    });

    /** 좋아요 버튼 클릭 - 화면 변화 */
    $(document).ready(function () {
        var liked = ${product.userLiked}; // 좋아요 초기화
        $("#like-link").click(function (event) {
            event.preventDefault(); // 링크의 기본 동작(페이지 이동)을 막음
            if (liked) {
                // 이미 좋아요를 누른 경우, 좋아요 취소 처리
                likeAction("unlike");
                $("#like-link img").attr("src", "/images/empty-like.png");
            } else {
                // 좋아요를 누르지 않은 경우, 좋아요 처리
                likeAction("like");
                $("#like-link img").attr("src", "/images/like.png");
            }
            liked = !liked; // 상태를 토글
        });
    });

    /** 좋아요 클릭 시 postAction */
    function likeAction(url) {
        $.ajax({
            type: "POST",
            url: url + "?product_id=" + ${product.id},
            success: function (data) {
                window.location.reload();
            },
            error: function () {
                alert("로그인 먼저 진행해주세요.");
                window.location.href = "/login";
            }
        });
    }

    /** 댓글 작성 */
    $(document).ready(function () {
        $("#submitButton").click(function () {
            const content = $("#commentText").val();
            $.ajax({
                type: "POST",
                url: "comment",
                data: {
                    content: content,
                    productId: ${product.id},
                    parentCommentId: 0 // 부모 댓글이라는 의미
                },
                success: function (response) {
                    location.reload();
                },
                error: function (xhr, status, error) {
                    alert(xhr.responseText);
                }
            });
        });
    });

    /** 대댓글 작성 */
    $(document).ready(function () {
        $(".reply-button").click(function () {
            // 대댓글 입력 칸 보이기/숨기기 토글
            const replyForm = $(this).closest(".comment").find(".reply-form");
            replyForm.slideToggle("fast");
        });

        $(".submit-reply-button").click(function () {
            const content = $(this).closest(".reply-form").find(".reply-textarea").val();
            var commentId = $(this).data("comment-id");
            $.ajax({
                url: "comment",
                method: "POST",
                data: {
                    content: content,
                    productId: ${product.id},
                    parentCommentId: commentId
                },
                success: function (data) {
                    location.reload();
                },
                error: function (xhr, status, error) {
                    alert(xhr.responseText);
                }
            });
        });
    });

    // 삭제 버튼 클릭
    $(".delete-button").on("click", function () {
        var commentId = $(this).data("comment-id");
        if (confirm("댓글을 삭제하시겠습니까?")) {
            $.ajax({
                type: "POST",
                url: "comment/delete?commentId=" + commentId,
                success: function (response) {
                    location.reload();
                },
                error: function (xhr, status, error) {
                }
            });
        }
    });

    // 삭제 버튼 클릭
    $("#couponButton").on("click", function () {
        var couponId = $('#coupons').val(); // 쿠폰 아이디
        if (couponId == 0) { // 선택 없음
            var updatedCost = ${product.cost}; // 할인가
            var formattedCost = new Intl.NumberFormat('ko-KR', {
                style: 'currency',
                currency: 'KRW'
            }).format(updatedCost);
            $('#updatedCost').html(formattedCost.replace('₩', '') + '원');
        } else { // 쿠폰 적용
            $.ajax({
                type: "POST",
                url: "coupon/apply?coupon_id=" + couponId,
                data: {
                    cost: ${product.cost}
                },
                success: function (response) {
                    updatedCost = parseInt(response);

                    // `updatedCost`의 값을 가져와서 원으로 표시
                    var formattedCost = new Intl.NumberFormat('ko-KR', {
                        style: 'currency',
                        currency: 'KRW'
                    }).format(updatedCost);

                    // `#updatedCost` 엘리먼트의 HTML을 변경하여 업데이트
                    $('#updatedCost').html(formattedCost.replace('₩', '') + '원');
                },
                error: function (xhr, status, error) {
                    alert("쿠폰 적용에 실패했습니다.");
                }
            });
        }
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
