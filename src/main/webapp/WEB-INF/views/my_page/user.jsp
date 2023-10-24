<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    .container {
        width: 400px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
        position: absolute;
        top: 45%;
        left: 57%;
        transform: translate(-50%, -50%);
    }

    h1 {
        text-align: center;
        color: #333;
    }

    form {
        margin-top: 20px;
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }

    input {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 3px;
    }

    button {
        display: block;
        padding: 10px;
        background-color: #333;
        color: #fff;
        border: none;
        border-radius: 3px;
        cursor: pointer;
    }
</style>
<head>
    <meta charset="UTF-8">
    <title>사용자 정보</title>
</head>
<body>
<div class="container">
    <h1>사용자 정보</h1>
    <img src="data:${user.type};base64,${user.encoding}" style="height: 80px; width: 80px;margin-left: 41%;">
    <form>
        <label for="name">사용자 이름</label>
        <input type="text" id="name" name="name" value="${user.name}" readonly>

        <label for="name">사용자 이메일</label>
        <input type="text" id="email" name="name" value="${user.email}" readonly>

        <label for="travel-tag">원하는 여행 태그를 입력해주세요.</label>
        <input type="text" id="travel-tag" name="travel-tag" value="${user.travelTag}" required>

        <div style="display: flex; justify-content: center; margin-top: 3%;">
            <button type="button" onclick="validation()" style="margin-right: 3%">수정하기</button>
        </div>
    </form>
</div>
</body>
</html>
<script>
    function validation() {
        var travelTag = document.getElementById("travel-tag")
        // 여행 태그 확인
        if (travelTag.value == "") {
            alert("여행 태그를 입력해주세요.")
            travelTag.focus();
            return false;
        }
        var formData = new FormData();
        formData.append("travelTag", $("#travel-tag").val());
        $.ajax({
            type: "POST",
            url: "user",
            data: formData,
            processData: false,
            contentType: false,
            success: function () {
                alert("사용자 정보를 수정했습니다.");
                window.location.href = "/";
            },
            error: function () {
                alert("사용자 정보 수정에 실패했습니다.");
            }
        });
    }
</script>
<%@ include file="../base_view/footer.jsp" %>