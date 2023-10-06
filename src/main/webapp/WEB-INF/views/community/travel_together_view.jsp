<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%@ include file="../base_view/header.jsp" %>
<%@ include file="../base_view/navigation.jsp" %>

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
        border-radius: 10px; /* 모서리 둥글게 만들기 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
        position: relative; /* 상대 위치 지정 - 게시글 div 우측 상단 버튼 위치 시키기 */
        margin-bottom: 3%;
    }

    .search-container label {
        font-size: 15px; /* 라벨의 글꼴 크기 설정 */
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

    .header-container h1 {
        margin: 0;
    }

    .header-container p {
        font-size: large;
        font-weight: bold;
        color: #555555;
    }

    .post-header {
        display: flex;
        align-items: center; /* 수직 정렬 */
        justify-content: space-between; /* 가로로 정렬 및 간격 설정 */
    }

    .post-header p {
        display: inline;
        margin-right: 10px; /* 원하는 간격 설정 */
    }

    /* 게시글 스타일 */
    .post {
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px; /* 모서리 둥글게 만들기 */
    }

    .post h2 {
        font-size: 24px;
        margin-bottom: 10px;
    }

    .post p {
        font-size: 16px;
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

    /* 답글 달기 버튼 스타일 */
    .reply-button {
        background: none; /* 배경 없애기 */
        border: none;
        padding: 0;
    }

    .country-container {
        margin-bottom: 15px;
    }

    .info-label {
        font-size: 16px;
        font-weight: bold;
        margin-right: 10px;
    }

    .info-text {
        font-size: 16px;
        margin: 0;
        display: inline-block;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div class="post-header">
            <h1>같이 여행 가요!</h1>
            <div class="post-details">
                <p>${post.userName}</p>
                <p>${post.createDate}</p>
                <p>${post.updateDate}</p>
            </div>
        </div>

        <div class="background-container">
            <div class="post" style="margin-bottom: 3%">
                <h2>${post.title}</h2>
            </div>


            <div class="background-container">
                <div class="country-container">
                    <label class="info-label">어디로 갈까요?</label>
                    <p class="info-text">${post.country} - ${post.city}</p>
                </div>
                <div class="country-container" style="margin-top: 3%">
                    <label class="info-label" style="margin-right: 3.5%">언제 갈까요?</label>
                    <p class="info-text">${post.startDate}부터</p>
                    <p class="info-text">${post.endDate}까지</p>
                </div>
                <div class="country-container" style="margin-top: 3%">
                    <label class="info-label" style="margin-right: 7%">모집 인원</label>
                    <p class="info-text">${post.recruitedNumber} / ${post.totalNum}</p>
                </div>
                <div class="country-container" style="margin-top: 3%">
                    <label class="info-label">모집 마감 날짜</label>
                    <p class="info-text">${post.deadline}</p>
                </div>
            </div>
            <div class="post">
                <p>${post.content}</p>
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
    /** 댓글 작성 */
    $(document).ready(function () {
        $("#submitButton").click(function () {
            const content = $("#commentText").val();
            $.ajax({
                type: "POST",
                url: "comment",
                data: {
                    content: content,
                    postId: ${post.id},
                    commentId: 0 // 부모 댓글이라는 의미
                },
                success: function (response) {
                    location.reload();
                },
                error: function (error) {
                    alert("댓글 작성에 실패했습니다.");
                    console.error(error);
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
                url: "reply",
                method: "POST",
                data: {
                    content: content,
                    postId: ${post.id},
                    parentCommentId: commentId
                },
                success: function (data) {
                    location.reload();
                },
                error: function (error) {
                    alert("대댓글 작성에 실패했습니다.");
                }
            });
        });
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
