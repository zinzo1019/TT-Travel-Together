<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title>여행에 대해 궁금해요.</title>
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
        padding-bottom: 6%;
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
        margin-bottom: 2%;
    }

    .country-container label {
        flex: 1; /* 라벨 요소가 가능한 한 더 크게 확장됨 */
        font-size: 18px;
        font-weight: bold;
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
        bottom: 3.5%;
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
                    <h1>여행에 대해 궁금해요.</h1>
                </div>
            </div>
        </div>
        <div class="background-container" style="margin-top: 4%">
            <div class="country-container">
                <label>어느 나라에 대해 궁금하신가요?</label>
                <select id="options" name="options">
                    <option value="0" ${post.countryId == 0 ? 'selected' : ''}>선택 없음</option>
                    <c:forEach items="${options}" var="option">
                        <option value="${option.countryId}" ${post.countryId == option.countryId ? 'selected' : ''}>
                                ${option.country} - ${option.city}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <label for="title" class="label">제목</label>
            <input type="text" id="title" name="title" required value="${post.title}">
            <label for="content" class="label">내용</label>
            <textarea id="content" required>${post.content}</textarea>
            <button class="search-button" id="submitButton">작성하기</button>
        </div>
    </div>
</div>
<script>
    const selectBox = document.getElementById("options");
    selectBox.addEventListener("change", () => {
        // 선택한 값을 가져옴
        const selectedValue = selectBox.value;
        console.log("선택한 값: " + selectedValue);
    });

    var submitButton = document.getElementById('submitButton');
    submitButton.addEventListener('click', function () {
        event.preventDefault(); // 기본 동작 중단
        var countryValue = document.getElementById('options').value;
        var titleValue = document.getElementById('title').value;
        var contentValue = document.getElementById('content').value;
        var errorMessage = '';

        if (countryValue == 0) {
            errorMessage += '어느 나라로 갈지 선택하세요.\n';
        }
        if (!titleValue) {
            errorMessage += '제목을 입력하세요.\n';
        }
        if (!contentValue) {
            errorMessage += '내용을 입력하세요.\n';
        }
        if (errorMessage) {
            alert(errorMessage);
        } else { // 게시글 수정
            var formData = new FormData();
            formData.append("id", ${post.id}) // 게시글 아이디
            formData.append("countryId", countryValue); // 나라
            formData.append("title", titleValue); // 제목
            formData.append("content", contentValue); // 내용
            formData.append("userId", ${post.userId}); // 내용
            $.ajax({
                type: 'POST',
                url: 'view',
                data: formData,
                processData: false,
                contentType: false,
                success: function (data) {
                    alert('게시글이 수정되었습니다.');
                    window.location.href = '/user/community/curious/view?postId=' + ${post.id};
                },
                error: function (xhr, error) {
                    alert(xhr.responseText);
                }
            });
        }
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
