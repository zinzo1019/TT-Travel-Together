<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="header-container">
    <div style="flex: 1; display: flex; align-items: center;">
        <h1>아래 내용을 찾으시나요?</h1>
        <p style="margin-left: 2%">${fn:length(posts)}건의 질문</p>
    </div>
    <button class="post-button" id="postButton">게시글 작성하기</button>
</div>
<ul class="post-list">
    <c:forEach var="post" items="${posts}">
        <li class="post-list-item">
            <a href="curious/view?postId=${post.postId}" style="text-decoration: none; color: inherit;">
                <div class="post">
                    <h2>${post.title}</h2>
                    <p style="margin: 3% 0">${post.content}</p>
                </div>
            </a>
        </li>
    </c:forEach>
</ul>
<script>
    /** 게시글 작성하기 버튼 클릭 -> 작성하기 페이지 */
    var postButton = document.getElementById('postButton'); // 게시글 작성 버튼
    postButton.addEventListener('click', function () {
        window.location.href = 'curious/post';
    });
</script>
