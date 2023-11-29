<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--콤마 추가--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 포트원 결제 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- 포트원 결제 -->

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
<title>이 상품은 어떠세요?</title>
<style>
    body {
        /*background-image: url('https://cdn.pixabay.com/photo/2020/03/18/14/48/clouds-4944276_640.jpg');*/
        background-image: url('https://cdn.pixabay.com/photo/2016/03/27/07/32/clouds-1282314_640.jpg');
        background-size: cover; /* 배경 이미지를 뷰포트에 맞게 확대/축소 */
        background-repeat: no-repeat; /* 배경 이미지 반복 비활성화 */
        background-attachment: fixed; /* 배경 이미지를 고정 (스크롤해도 배경 이미지가 고정됨) */
        background-position: center center; /* 배경 이미지를 중앙에 위치시킴 */
        height: 100vh; /* 화면 높이만큼 배경 이미지 표시 */
        width: 100%;
        max-width: 2000px;
        margin: 0 auto;
    }

    .welcome-message button {
        padding: 0;
        margin: 0 11px;
    }

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
        margin-bottom: 5%;
    }

    /* 여행 상품 컨테이너 */
    .travel-container {
        margin: 5% 0;
        border: 1px solid #ddd;
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
        padding: 3%;
        background-color: white;
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

    .tag-a {
        color: black;
        padding-right: 2%;
        text-decoration: none;
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
        margin-right: 13%;
    }

    .background-container {
        background-color: #f0f0f0; /* 원하는 배경 색상으로 설정 */
        padding: 20px; /* 내부 여백 추가 */
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        margin-bottom: 5%;
    }

    .description-container {
        padding: 3% 3% 0 3%;
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

    #like-link {
        position: relative;
    }

    .like-img {
        position: absolute;
        width: 23px;
        height: 23px;
        top: 5px;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="travel-container">
            <div class="img-container">
                <div class="img" style="display: inline-block;">
                    <img src="data:${product.type};base64,${product.encoding}" style="border-radius: 10px;">
                </div>
                <div class="text">
                    <div>
                        <%--    로그인 상태--%>
                        <c:if test="${not empty pageContext.request.userPrincipal }">
                            <a href="#" class="no-style" id="like-link">
                                <img src="${product.userLiked ? '/images/like.png' : '/images/empty-like.png'}"
                                     class="like-img">
                            </a>
                        </c:if>
                        <%--    로그아웃 상태--%>
                        <c:if test="${empty pageContext.request.userPrincipal }">
                            <a href="#" class="no-style" id="like-link">
                                <img src='/images/empty-like.png' class="like-img">
                            </a>
                        </c:if>
                        <div style="margin-left: 30px;">
                            <span>${product.like}</span>

                            <c:choose>
                                <c:when test="${product.enabled}">
                                    <p style="font-size: small; color: blue; display: inline-block;">* 판매 중인 상품입니다.</p>
                                </c:when>
                                <c:otherwise>
                                    <p style="font-size: small; color: red; display: inline-block">* 판매 중지된 상품입니다.</p>
                                </c:otherwise>
                            </c:choose>

                            <span id="temperature"
                                  style="color: darkgreen; font-size: medium; float: right; margin-right: 3%; padding-top: 2%;">현재 온도: </span>
                        </div>
                    </div>
                    <p>[${product.country}
                        - ${product.city}] ${product.name}${product.descriptions}</p>
                    <fmt:formatNumber value="${product.cost}" pattern="#,###"/> 원
                    <!-- 쿠폰 창 -->
                    <div class="coupon-form">
                        <div class="form-group">
                            <select class="form-control" id="coupons" name="coupons">
                                <option value="0">선택 없음</option>
                                <c:forEach items="${product.coupons}" var="coupon">
                                    <c:choose>
                                        <c:when test="${coupon.percentage > 0}">
                                            <option value="${coupon.couponId}">
                                                    ${coupon.name} ---> ${coupon.percentage}% 할인
                                            </option>
                                        </c:when>
                                        <c:when test="${coupon.amount > 0}">
                                            <option value="${coupon.couponId}">
                                                    ${coupon.name} ---> ${coupon.amount} 원 할인
                                            </option>
                                        </c:when>
                                    </c:choose>
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
                        <button class="checkoutButton" id="payment">결제하기</button>
                    </div>
                    <div class="tag-div">
                        <c:forEach var="tag" items="${product.tags}" varStatus="status">
                            <a class="tag-a" href="/guest/all/products/tag?tag=${tag.tag}"># ${tag.tag}</a>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="description-container">
                ${product.description}
            </div>
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
                                <c:when test="${comment.userId eq user.userId}">
                                    <button class="reply-button delete-button" style="margin-top: 0%; color: red;"
                                            data-comment-id="${comment.commentId}">삭제
                                    </button>
                                </c:when>
                            </c:choose>
                        </div>
                        <!-- 대댓글 입력 칸 (초기에는 숨김) -->
                        <div class="reply-form" style="display: none;">
                            <textarea class="reply-textarea" placeholder="대댓글을 입력하세요"></textarea>
                            <button class="submit-reply-button submit-comment-button" data-comment-id="${comment.commentId}">
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
    var userId; // 사용자 아이디
    var updatedCost; // 전역 변수로 선언

    $(document).ready(function () {
        updatedCost = ${product.cost}; // 할인가
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
            url: url + "?product_id=" + ${product.travelProductId},
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
                    productId: ${product.travelProductId},
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
                    productId: ${product.travelProductId},
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

    // 쿠폰 적용 버튼 클릭
    $("#couponButton").on("click", function () {
        var couponId = $('#coupons').val(); // 쿠폰 아이디
        if (couponId == 0) { // 선택 없음
            updatedCost = ${product.cost}; // 할인가
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

    /** 결제 금액 변경되지 않도록 */
    function generateUniqueMerchantUid() {
        var today = new Date();
        var hours = today.getHours();
        var minutes = today.getMinutes();
        var seconds = today.getSeconds();
        var milliseconds = today.getMilliseconds();
        return hours + "" + minutes + "" + seconds + "" + milliseconds; // 고유한 값
    }

    /** 결제하기 버튼 글릭 시 */
    const buyButton = document.getElementById('payment')
    buyButton.setAttribute('onclick', `handleKakaoPay()`)


    /** 결제하기 로직 - 비동기 처리 */
    // async 함수 -> Promise 반환
    // Promise는 비동기 작업이 완료되기를 기다릴 수 있게 함
    async function handleKakaoPay() {
        try {
            const paymentResponse = await KakaoPay();
        } catch (error) {
            alert("결제에 실패했습니다.");
            console.error("Payment Error:", error);
        }
    }

    var IMP = window.IMP;
    async function KakaoPay() {
        if (!${product.enabled}) {
            alert("판매 중지된 상품입니다.\n다음에 다시 이용해주세요.");
            return;
        }

        if (confirm("구매하시겠습니까?")) {
            if ("${user.email}" !== "") {
                try {
                    const paymentResponse = await requestKakaoPay();
                    console.log(paymentResponse);
                    const userId = "${user.userId}" === "" ? 0 : "${user.userId}";
                    const couponId = $('#coupons').val();
                    if (couponId !== 0) {
                        // await - Promise가 처리될 때까지 실행을 일시 중지
                        await applyCoupon(paymentResponse, userId, couponId);
                    }
                    await savePaymentToDatabase(paymentResponse, userId);
                    alert("결제가 완료됐습니다.");
                } catch (error) {
                    alert("결제에 실패했습니다.");
                    console.error(error);
                }
            } else {
                alert('로그인이 필요한 서비스입니다.');
                window.location.href = '/login';
            }
        } else {
            return false;
        }
    }

    function requestKakaoPay() {
        return new Promise((resolve, reject) => {
            const merchantUid = "IMP" + generateUniqueMerchantUid();

            IMP.init("imp75526378");
            IMP.request_pay({
                pg: 'kakaopay.TC0ONETIME',
                pay_method: 'card',
                merchant_uid: merchantUid,
                productId: ${product.travelProductId},
                name: "${product.name}",
                amount: updatedCost,
                buyer_email: `${user.email}`,
                buyer_name: `${user.name}`
            }, function (rsp) {
                if (rsp.success) {
                    resolve(rsp);
                } else {
                    reject(new Error(rsp.error_msg));
                }
            });
        });
    }

    function applyCoupon(paymentResponse, userId, couponId) {
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/user/product/payment/coupon",
                data: {
                    impUid: paymentResponse.imp_uid,
                    pgTid: paymentResponse.pg_tid,
                    productId: ${product.travelProductId},
                    userId: userId,
                    paidAmount: paymentResponse.paid_amount,
                    couponId: couponId
                },
                success: function (response) {
                    resolve(response);
                },
                error: function (xhr, status, error) {
                    reject(error);
                }
            });
        });
    }

    function savePaymentToDatabase(paymentResponse, userId) {
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "/user/product/payment",
                data: {
                    impUid: paymentResponse.imp_uid,
                    productId: ${product.travelProductId},
                    userId: userId,
                    merchantUid: paymentResponse.merchant_uid,
                    paidAmount: paymentResponse.paid_amount,
                    paidAt: paymentResponse.paid_at,
                    pgProvider: paymentResponse.pg_provider,
                    pgTid: paymentResponse.pg_tid,
                    receiptUrl: paymentResponse.receipt_url
                },
                success: function (response) {
                    resolve(response);
                    alert("결제가 완료됐습니다.");
                },
                error: function (xhr, status, error) {
                    reject(error);
                }
            });
        });
    }

    /** 날씨 띄우기 */
    $(document).ready(function () {
        var koreanCityName = '${product.city}';
        var englishCityName = cityNameToEnglish(koreanCityName);
        displayWeather(englishCityName);
    });

    // 날씨 정보를 가져와서 표시하는 함수
    function displayWeather(englishCityName) {
        var apiUrl = 'http://localhost:8081/guest/weather/' + englishCityName + '&units=metric';

        $.ajax({
            url: apiUrl,
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log('날씨 데이터:', data);
                var temperature = data.main.temp.toFixed(1); // 소수 첫 째 자리까지 제한
                var temperatureElement = $('#temperature');
                temperatureElement.text('현재 온도: ' + temperature + '°C');
            },
            error: function (xhr, status, error) {
                console.error('오류:', error);
            }
        });
    }

    /** 도시 이름 -> 영어 변환 */
    function cityNameToEnglish(cityName) {
        // 도시 이름을 한글에서 영어로 변환하는 매핑 테이블
        var cityMapping = {
            '서울': 'seoul',
            '부산': 'busan',
            '도쿄': 'tokyo',
            '오사카': 'osaka',
            '뉴욕': 'new york',
            '로스앤젤레스': 'los-angeles',
            '시드니': 'sydney',
            '코타키나발루': 'kota kinabalu',
            '런던': 'london',
            '프라하': 'prague',
            '코펜하겐': 'copenhagen',
            '파리': 'paris'
        };
        return cityMapping[cityName] || cityName;
    }
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
