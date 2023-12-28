<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="header-container">
    <div style="flex: 1; display: flex; align-items: center;">
        <h1>${user.name}님에게 딱 맞는 모집글을 찾았어요.</h1>
        <p style="margin-left: 2%">${fn:length(postsByTrue)}건의 여행 모집</p>
    </div>
</div>
<ul class="post-list" id="postList">
    <%--                모집 마감 전--%>
    <c:forEach var="post" items="${postsByTrue}">
        <li class="post-list-item">
            <a href="/user/community/together/view?postId=${post.postId}" style="text-decoration: none; color: inherit;">

                <div class="post">
                    <p style="margin: 1% 0; color: red; font-weight: bold; font-size: 13px;">${post.recruitedNumber}명이 함께하고 있어요!</p>
                    <h2>${post.title}</h2>
                    <p>${post.content}</p>
                    <c:choose>
                        <c:when test="${post.email eq user.email}">
                            <!-- 만약 현재 사용자가 글의 작성자라면 '모집 마감하기' 버튼을 표시 -->
                            <button class="support-button closeRecruitmentButton" data-post-id="${post.postId}"
                                    style="background-color: #1633b9">모집 마감하기
                            </button>
                        </c:when>
                        <c:otherwise>
                            <!-- 그렇지 않으면 '지원하기' 버튼을 표시 -->
                            <button class="support-button pushRecruitmentButton" data-post-id="${post.postId}"
                                    style="background-color: #c40000">지원하기
                            </button>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${post.remainingDays eq 0}">
                            <%--                                        지원 마감 날짜가 오늘이라면--%>
                            <p style="position: absolute; top: 18%; right: 2%; font-size: small">모집 마감 D-DAY</p>
                        </c:when>
                        <c:otherwise>
                            <%--                                        지원 마감 날짜가 오늘이 아니라면--%>
                            <p style="position: absolute; top: 18%; right: 2%; font-size: small">모집 마감
                                D-${post.remainingDays}</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </a>
        </li>
    </c:forEach>
    <%--                모집 마감 후--%>
    <%--        <c:forEach var="post" items="${postsByFalse}">--%>
    <%--            <li class="post-list-item">--%>
    <%--                <div class="post">--%>
    <%--                    <p style="margin: 1% 0">${post.recruitedNumber}명이 함께하고 있어요!</p>--%>
    <%--                    <h2>${post.title}</h2>--%>
    <%--                    <p>${post.content}</p>--%>
    <%--                    <button class="support-button">모집 마감</button>--%>
    <%--                </div>--%>
    <%--            </li>--%>
    <%--        </c:forEach>--%>
</ul>
<script>
    /** '모집 마감하기' 버튼 클릭 이벤트 핸들러 */
    $(document).ready(function () {
        $(".closeRecruitmentButton").click(function () {
            var postId = $(this).data("post-id");
            $.ajax({
                url: "together/close?postId=" + postId,
                method: "POST",
                success: function (data) {
                    alert("모집이 마감되었습니다.");
                    location.reload();
                },
                error: function (error) {
                    alert("모집 마감에 실패했습니다.");
                }
            });
        });
    });

    /** '지원하기' 버튼 클릭 이벤트 핸들러 */
    $(document).ready(function () {
        $(".pushRecruitmentButton").click(function () {
            var postId = $(this).data("post-id");
            $.ajax({
                url: "together/apply?postId=" + postId,
                method: "POST",
                success: function (data) {
                    alert("지원을 완료했습니다.");
                    location.reload();
                },
                error: function (xhr, status, error) {
                    alert(xhr.responseText);
                    location.reload();
                }
            });
        });
    });
</script>