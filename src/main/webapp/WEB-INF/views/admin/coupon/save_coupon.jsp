<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>쿠폰 등록하기</title>


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
        margin-top: 3%;
    }

    .background-container {
        background-color: #f0f0f0; /* 원하는 배경 색상으로 설정 */
        padding: 20px; /* 내부 여백 추가 */
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        padding-bottom: 70px;
    }

    .search-container label {
        font-size: 15px; /* 라벨의 글꼴 크기 설정 */
    }

    /* 검색창 컨테이너 스타일 */
    .travel-container {
        margin-top: 5%;
        margin-left: 1%;
    }

    .country-container {
        display: flex;
        align-items: center; /* 세로 중앙 정렬 */
    }

    .country-container label {
        flex: 1; /* 라벨 요소가 가능한 한 더 크게 확장됨 */
        font-size: 18px;
        font-weight: bold;
    }

    .country-container button {
        background-color: black;
        color: white;
        border-radius: 5px;
        border: 0;
        padding: 10px 10px;
        margin-left: 3%;
    }

    .country-container select, input {
        flex: 2; /* 입력 상자 요소가 라벨보다 두 배로 확장됨 */
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }

    .header-container {
        display: flex;
        align-items: center;
    }

    .header-container h1 {
        margin: 0;
    }

    .header-container p {
        font-size: large;
        font-weight: bold;
        color: #555555;
    }

    /** 지원하기 / 취소하기 / 지원마감 버튼 */
    .search-button {
        background-color: #333;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        position: absolute; /* 절대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        bottom: 4%;
        right: 3%;
    }

    .post h2 {
        font-size: 24px;
        margin-bottom: 10px;
    }

    .post p {
        font-size: 16px;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-bottom: 10px;
    }
    textarea {
        height: 150px;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="travel-container">
            <div class="header-container">
                <div style="flex: 1; display: flex; align-items: center;">
                    <h1>어떤 쿠폰을 등록할까요?</h1>
                </div>
            </div>
        </div>
        <div class="background-container" style="margin-top: 4%">
            <div class="country-container">
                <label>어느 나라의 쿠폰인가요?</label>
                <select id="countries" name="countries" style="flex: 1.75;">
                    <option value="0">선택 없음</option>
                    <c:forEach items="${countries}" var="country">
                        <option value="${country.countryId}">
                                ${country.country} - ${country.city}
                        </option>
                    </c:forEach>
                </select>
                <button id="countrySelect">선택</button>
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>어느 여행 상품의 쿠폰인가요?</label>
                <select id="products" name="products" multiple>
                    <option value="-1">선택 없음</option>
                    <c:forEach items="${products}" var="product">
                        <option value="${product.travelProductId}">
                                [${product.travelProductId}] ${product.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="country-container" style="margin-top: 3%">
            <label>할인율과 가격 중 둘 중 하나만 선택하세요.</label>
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>할인율</label>
                <input type="number" id="percentage">
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>가격</label>
                <input type="number" id="amount">
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>쿠폰 이름</label>
                <input type="text" id="name">
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>쿠폰 설명</label>
                <input type="text" id="description">
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>쿠폰 개수</label>
                <input type="number" id="coupon-count">
            </div>
            <button class="search-button" id="submitButton">작성하기</button>
        </div>
    </div>
</div>
</body>
</html>
<script>
    /** 나라 선택 버튼 클릭 */
    $(document).ready(function() {
        $("#countrySelect").click(function() {
            var countryId = $("#countries").val();
            $.ajax({
                type: "POST",
                url: "countrySelect/action?countryId=" + countryId,
                success: function(data) {
                    // 서버에서 반환한 products 데이터를 사용하여 select 옵션 업데이트
                    var productsSelect = $("#products");
                    productsSelect.empty();
                    productsSelect.append($('<option>', { value: 0, text: '전체' }));
                    data.products.forEach(function(product) {
                        productsSelect.append($('<option>', { value: product.travelProductId, text: '[' + product.travelProductId + '] ' + product.name }));
                    });
                },
                error: function() {
                }
            });
        });
    });

    /** 쿠폰 등록 버튼 클릭 */
    document.getElementById("submitButton").addEventListener("click", function(event) {
        event.preventDefault();
        var countryId = document.getElementById("countries").value;
        var name = document.getElementById("name").value;
        var description = document.getElementById("description").value;
        var percentage = document.getElementById("percentage").value;
        var amount = document.getElementById("amount").value;
        var couponCount = document.getElementById("coupon-count").value;

        // 여행 상품 아이디 담기
        var selectedProductIds = [];
        var selectElement = document.getElementById("products");
        var options = selectElement && selectElement.options;
        if (options) {
            for (var i = 0; i < options.length; i++) {
                if (options[i].selected && options[i].value !== "-1") {
                    selectedProductIds.push(parseInt(options[i].value, 10));
                }
            }
        }

        // 유효성 검사
        if (countryId === "0") {
            alert("여행지를 선택하세요.");
            return false;
        }
        if (selectElement.value === "") {
            alert("여행 상품을 선택하세요.");
            return false;
        }
        if ((percentage && amount) || (!percentage && !amount)) {
            alert("할인율 또는 가격 중 하나를 입력하세요.");
            return false;
        }
        if (percentage < 0 || percentage > 100) {
            alert("할인율은 0과 100 사이의 숫자여야 합니다.");
            return false;
        }
        if (amount < 0) {
            alert("가격은 0원 이상이어야 합니다.");
            return false;
        }
        if (percentage == "") { // 입력이 안 됐을 경우 초기화
            percentage = 0;
        }
        if (amount == "") {
            amount = 0;
        }
        if (couponCount === "") {
            alert("쿠폰의 개수를 입력해주세요.");
            return false;
        }
        if (couponCount < 0 || couponCount > 300) {
            alert("쿠폰 개수는 0개 이상 300이하여야 합니다.");
            return false;
        }

        var data = {
            productIds: selectedProductIds,
            percentage: percentage,
            amount: amount,
            name: name,
            description: description,
            countryId: countryId,
            couponCount: couponCount
        };

        $.ajax({
            type: "POST",
            url: "save",
            data: data,
            success: function(response) {
                alert("쿠폰 작성이 완료되었습니다.");
                window.location.href = 'my';
            },
            error: function() {
                alert("쿠폰 작성 중 오류가 발생했습니다.");
            }
        });
    });
</script>
<%@ include file="../base_view/footer.jsp" %>