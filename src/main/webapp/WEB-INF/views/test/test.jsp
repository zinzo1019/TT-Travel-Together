<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Send Mail</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<h1>메일 보내기</h1>

<div class="container">
    <div style="float: left; width: 50%;">
        <h1>텍스트 메일 보내기</h1>

        <form action="/guest/mail/send" method="post" enctype="multipart/form-data">
            <table>
                <tr id="box" class="form-group">
                    <td>받는 사람</td>
                    <td>
                        <input type="text" class="form-control" name="address" placeholder="이메일 주소를 입력하세요">
                    </td>
                    <td>
                        <input type="button" class="form-control" value="추가" onclick="add_mail_address(this)">
                    </td>
                </tr>
                <tr class="form-group">
                    <td>제목</td>
                    <td>
                        <input type="text" class="form-control" name="title" placeholder="제목을 입력하세요">
                    </td>
                </tr>
                <tr class="form-group">
                    <td>내용</td>
                    <td>
                        <textarea class="form-control" name="content" placeholder="보낼 내용을 입력하세요"> </textarea>
                    </td>
                </tr>
                <tr class="form-group">
                    <td>첨부 파일</td>
                    <td>
                        <input type="file" name="file" class="file-input"/>
                    </td>
                </tr>
            </table>
            <button class="btn btn-default">발송</button>
        </form>

    </div>
</div>
</body>
</html>

<script>
    const add_mail_address = (obj) => {
        const box = obj.parentElement.parentElement;
        const newP = document.createElement("tr");

        newP.innerHTML = "<tr class='form-group'><td>메일 주소</td><td><input type='text' class='form-control' name='address' ></td><td><input type='button' class='form-control' value='삭제' onclick='opt_remove(this)'></td></tr>";
        box.parentNode.insertBefore(newP, box.nextSibling);
    }

    const opt_remove = (obj) => {
        obj.parentElement.parentElement.parentElement.removeChild(obj.parentElement.parentElement);
    }

    const opt_remove2 = (obj) => {
        obj.parentElement.parentElement.parentElement.removeChild(obj.parentElement.parentElement);
    }
</script>