<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!DOCTYPE html>
<html>
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
        top: 50%;
        left: 50%;
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
        width: 95%;
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

    .email-container {
        padding-bottom: 10px;
        display: flex;
        align-items: center; /* 수직 정렬 */
    }

    .email-input {
        width: 70%;
        margin-right: 5%;
        padding: 10px;
        margin-bottom: 0px;
    }
</style>
<head>
    <meta charset="UTF-8">
    <title>일반 회원가입</title>
</head>
<body>
<div class="container">
    <h1>일반 회원가입</h1>
    <form>
        <label for="email" style="padding-right: 5%">이메일</label>
        <div class="email-container">
            <input type="email" id="email" name="email" class="email-input" required>
            <button id="idCheck" name="idDuplication" type="submit">중복 확인</button>
            <d id="idAvailable" class="valid-feedback" style="display: none;"></d>
            <d id="idNotAvailable" class="invalid-feedback" style="display: none;"></d>
        </div>

        <label for="name">사용자 이름</label>
        <input type="text" id="name" name="name" required>


        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" required>


        <label for="cpassword">비밀번호 확인</label>
        <input type="password" id="cpassword" name="cpassword" required>

        <label for="imageInput">이미지</label>
        <input type="file" name="image" id="imageInput" required>
        <p id="imageErrorMessage" class="text-danger"></p>

        <div style="display: flex; justify-content: center;">
            <button type="button" onclick="validation()" style="margin-right: 3%">가입하기</button>
            <button type="button" id="admin-button">관리자입니까?</button>
        </div>
    </form>
</div>
</body>
</html>
<script>
    var isDuplicated = null; // 이메일 중복 여부

    // 이메일
    var regId = /(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))/
    // 비밀번호
    var regpassword = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]).{4,12}$/;
    // 이름
    var regName = /^[가-힣a-zA-Z]{2,15}$/;

    // 아이디 중복 체크
    $("#idCheck").click(function () {
        var email = document.getElementById("email")
        // 아이디 확인
        if (email.value == "") {
            alert("이메일을 입력하세요.")
            email.focus();
            return false;
        } else if (!regId.test(email.value)) {
            alert("이메일 양식에 맞게 입력해주세요.")
            email.focus();
            return false;
        }

        $.ajax({
            url: "/ROLE_GUEST/email/check",
            type: "GET",
            data: {
                email: $('#email').val()
            },
            success: function () {
                alert("사용가능한 아이디입니다.")
                isDuplicated = false;
            }, error: function () {
                alert("중복된 아이디입니다.")
                isDuplicated = true;
            }
        });
        return false;
    })

    function validation() {
        var password = document.getElementById("password")
        var cpassword = document.getElementById("cpassword")
        var name = document.getElementById("name")
        var image = document.getElementById("imageInput")

        // 아이디 확인
        if (email.value == "") {
            alert("이메일을 입력하세요.")
            email.focus();
            return false;
        } else if (!regId.test(email.value)) {
            alert("이메일 양식에 맞게 입력해주세요.")
            email.focus();
            return false;
        }
        // 비밀번호 확인
        if (password.value == "") {
            alert("비밀번호를 입력하세요.")
            password.focus();
            return false;
        }
        // 아이디 중복 체크 (비어있으면 중복 체크 전)
        if (isDuplicated == null) {
            alert("아이디 중복 체크를 해주세요.")
            return false;
        }
        // 비밀번호 영어 대소문자 확인
        if (!regpassword.test(password.value)) {
            alert("비밀번호에는 4~12자 영문 대소문자, 숫자, 특수기호를 모두 포함하세요.")
            password.focus();
            return false;
        }
        // 이름 확인
        if (!regName.test(name.value)) {
            alert("최소 2글자 이상, 한글과 영어만 입력하세요.")
            name.focus();
            return false;
        }
        // 이미지 확인
        if (image.value == "") {
            alert("이미지를 선택해주세요")
            return false;
        }
        // 비밀번호 확인
        if (cpassword.value !== password.value) {
            alert("비밀번호와 동일하지 않습니다.")
            cpassword.focus();
            return false;
        }

        var formData = new FormData();
        formData.append("email", $("#email").val());
        formData.append("password", $("#password").val());
        formData.append("name", $("#name").val());
        formData.append("image", $("#imageInput")[0].files[0]);

        $.ajax({
            type: "POST",
            url: "/ROLE_GUEST/signup-process",
            data: formData,
            processData: false,
            contentType: false,
            success: function () {
                alert("회원가입을 성공했습니다.");
                window.location.href = "login";
            },
            error: function () {
                alert("회원가입 실패!");
            }
        });
    }

    // 관리자입니까 - 버튼 클릭
    document.getElementById("admin-button").addEventListener("click", function () {
        window.location.href = "/signup/admin";
    });
</script>
