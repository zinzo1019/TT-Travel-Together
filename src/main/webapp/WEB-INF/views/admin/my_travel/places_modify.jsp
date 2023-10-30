<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://cdn.ckeditor.com/4.17.1/standard/ckeditor.js"></script>
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
<title>여행지 수정하기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
        margin-top: 4%;
    }

    .background-container {
        background-color: #f0f0f0; /* 원하는 배경 색상으로 설정 */
        padding: 20px; /* 내부 여백 추가 */
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
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

    .country-container select, input, img {
        flex: 2; /* 입력 상자 요소가 라벨보다 두 배로 확장됨 */
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }

    .tag-container div {
        display: inline-block; /* 한 줄에 표시 */
        margin-right: 2%;
    }

    .tag-container p {
        display: inline-block; /* 한 줄에 표시 */

        border: 1px solid #ccc; /* 테두리 스타일과 색상 설정 */
        border-radius: 15px; /* 둥근 테두리 반지름 설정 */
        padding: 5px 10px; /* 내부 여백 설정 */
    }

    .tag-container button {
        display: inline-block; /* 한 줄에 표시 */
        padding: 0;
        border: 0;
        color: red;
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

    .label {
        font-size: 18px;
        font-weight: bold;
        display: block;
        margin-bottom: 1%;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="travel-container">
            <div class="header-container">
                <div style="flex: 1; display: flex; align-items: center;">
                    <h1>여행지를 어떻게 수정할까요?</h1>
                </div>
            </div>
        </div>
        <div class="background-container" style="margin-top: 4%">
            <div class="country-container">
                <label>어느 나라인가요?</label>
                <select id="options" name="options">
                    <option value="${product.countryId}">${product.country} - ${product.city}</option>
                    <c:forEach items="${options}" var="option">
                        <option value="${option.countryId}">
                                ${option.country} - ${option.city}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div id="descriptions">
                <div class="country-container" style="margin-top: 3%">
                    <label>간단한 설명을 추가하세요.</label>
                    <input type="text" class="simple-desc" style="flex: 1.72">
                    <button class="add-description-button">추가</button>
                </div>
                <div class="tag-container">
                    <c:forEach items="${product.detailDescriptions}" var="description">
                        <div>
                            <p>${description.description}</p>
                            <button class="delete-button description-delete-button" data-description-id=${description.travelProductDetailId}>X</button>
                        </div>
                    </c:forEach>
                </div>
                <div id="description_container" class="tag-container"></div>
            </div>
            <div id="tags">
                <div class="country-container" style="margin-top: 3%">
                    <label>태그를 추가하세요.</label>
                    <input type="text" class="tag" style="flex: 1.72">
                    <button class="add-tag-button">추가</button>
                </div>
                <div class="tag-container">
                    <c:forEach items="${product.tags}" var="tag">
                        <div>
                            <p>${tag.tag}</p>
                            <button class="delete-button tag-delete-button" data-tag-id=${tag.productTagId}>X</button>
                        </div>
                    </c:forEach>
                </div>
                <div id="tag_container" class="tag-container"></div>
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>얼마인가요?</label>
                <input type="number" id="cost" value="${product.cost}">
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>이미지를 등록하세요.</label>
                <input type="file" name="image" id="imageInput" required>
            </div>
            <div class="country-container" style="margin-top: 3%">
            <label>기존 이미지</label>
            <img src="data:${product.type};base64,${product.encoding}" style="border-radius: 15px;">
            </div>
        </div>
        <div class="background-container" style="margin-top: 4%; padding-bottom: 4%">
            <label for="name" class="label">상품 이름</label>
            <input type="text" id="name" name="name" value="${product.productName}" required>
            <label for="description" class="label">세부 설명</label>
            <textarea id="description" required>${product.description}</textarea><br><br>
            <button class="search-button" id="submitButton">작성하기</button>
        </div>
    </div>
</div>
<script>
    var descriptionsData = [];
    var tagsData = [];

    // 설명 추가 버튼 클릭 시
    document.querySelectorAll(".add-description-button").forEach(function (button) {
        button.addEventListener("click", function () {
            var descriptionContainer = button.parentElement;
            var input = descriptionContainer.querySelector(".simple-desc").value;

            var p_tag = document.createElement("p"); // p 태그
            p_tag.textContent = input; // tag 삽입
            p_tag.style.marginRight = "2%";

            document.getElementById("description_container").appendChild(p_tag);
            descriptionsData.push(input); // 배열에 넣기
            var inputField = document.querySelector(".simple-desc");
            inputField.value = "";
        });
    });

    // 태그 추가 버튼 클릭 시
    document.querySelectorAll(".add-tag-button").forEach(function (button) {
        button.addEventListener("click", function () {
            var tagContainer = button.parentElement;
            var input = tagContainer.querySelector(".tag").value;

            var p_tag = document.createElement("p"); // p 태그
            p_tag.textContent = input; // tag 삽입
            p_tag.style.marginRight = "2%";

            document.getElementById("tag_container").appendChild(p_tag);
            tagsData.push(input);
            var inputField = document.querySelector(".tag");
            inputField.value = "";
        });
    });

    /** 설명 삭제 */
    $(".description-delete-button").click(function () {
        const descriptionId = $(this).data("description-id");
        $.ajax({
            url: "delete/description?description_id=" + descriptionId,
            type: "POST",
            success: function (data) {
                window.location.reload();
            },
            error: function (error) {
            }
        });
    });

    /** 태그 삭제 */
    $(".tag-delete-button").click(function () {
        const tagId = $(this).data("tag-id");
        $.ajax({
            url: "delete/tag?tag_id=" + tagId,
            type: "POST",
            success: function (data) {
                window.location.reload();
            },
            error: function (error) {
            }
        });
    });

    document.getElementById("imageInput").addEventListener("change", function () {
        var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif|\.jfif)$/i;
        if (!allowedExtensions.exec(this.value)) {
            alert("올바른 이미지 확장자를 사용해주세요 (jpg, jpeg, png, gif만 허용).");
            this.value = "";
            return false;
        }
    });

    document.addEventListener("DOMContentLoaded", function () {
        CKEDITOR.replace('description');
    });

    /** 제출 버튼 클릭 - 유효성 검사 */
    var submitButton = document.getElementById('submitButton');
    submitButton.addEventListener('click', function () {
        event.preventDefault(); // 기본 동작 중단
        var countryValue = document.getElementById('options').value; // 나라 아이디 (기본키)
        var cost = document.getElementById('cost').value; // 가격
        var name = document.getElementById('name').value; // 상품 이름
        var description = CKEDITOR.instances['description'].getData(); // 상품 설명
        var image = document.getElementById("imageInput").value; // 이미지

        if (countryValue == 0) {
            alert('어느 나라로 갈지 선택하세요.');
            return false;
        }
        if (!cost) {
            alert('상품 가격을 입력하세요.');
            return false;
        }
        if (!name) {
            alert('상품 이름을 입력하세요.');
            return false;
        }
        if (!description) {
            alert('상품 설명을 입력하세요.');
            return false;
        } else { // 게시글 저장
            var formData = new FormData();
            formData.append("travelProductId", ${product.travelProductId}); // 여행 상품 아이디
            formData.append("countryId", countryValue); // 나라 아이디
            formData.append("cost", cost);
            formData.append("productName", name);
            formData.append("description", description);
            formData.append("userId", ${user.userId});
            formData.append("stringDetailDescriptions", descriptionsData);
            formData.append("stringTags", tagsData);

            if (image) { // 이미지가 있을 때만 넣기
                formData.append("image", $("#imageInput")[0].files[0]);
            }

            $.ajax({
                type: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                success: function (data) {
                    alert('게시글이 작성되었습니다.');
                    window.location.href = '/admin/my-travel-places';
                },
                error: function (error) {
                    alert('게시글 작성에 실패했습니다.');
                }
            });
        }
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>