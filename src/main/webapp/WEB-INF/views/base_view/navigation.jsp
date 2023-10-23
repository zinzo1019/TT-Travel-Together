<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    /* 네비게이션 바 스타일 */
    nav {
        position: fixed;
        top: 50px; /* 헤더의 높이만큼 여백 추가 */
        left: 0;
        width: 18%; /* 화면 너비의 18%로 설정 */
        height: 100%; /* 화면 전체 높이에 맞추세요. */
        background-color: #333;
        color: white;
        max-height: 800px; /* 원하는 높이로 설정합니다. */
        overflow-y: scroll; /* 세로 스크롤을 추가합니다. */
        scrollbar-width: thin; /* 스크롤 바의 두께 설정 */
        scrollbar-color: transparent transparent; /* 스크롤 바 색상 설정 */
    }

    /* 스크롤 바 숨김 스타일 */
    nav::-webkit-scrollbar {
        width: 6px; /* 스크롤 바의 너비 설정 */
    }

    nav::-webkit-scrollbar-thumb {
        background-color: transparent; /* 스크롤 바의 색상을 투명으로 설정하여 숨깁니다. */
    }

    nav ul {
        list-style-type: none;
        margin: 0;
        margin-top: 15%;
        padding: 0;
        padding-bottom: 70px;
    }

    nav ul li {
        margin: 10px 0;
    }

    nav ul li a {
        display: block;
        text-decoration: none;
        color: white;
        font-weight: bold;
        padding: 10px;
    }

    /* 네비게이션 바 hover 스타일 */
    nav ul li a:hover {
        background-color: #555;
    }

    .child-title {
        margin-left: 10%;
        padding: 5px;
    }

    .parent-board {
        padding: 10px;
        font-weight: bold;
    }

    .dropdown-menu {
        display: none;
    }
</style>
<nav>
    <ul>
        <li><a href="/">어디로 여행을 떠날까요?</a></li>
        <li class="dropdown">
            <a href="#" class="child-title dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                어디로 갈지 모르겠어요 <i class="fa fa-caret-down"></i>
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="/guest/all/products" style="margin-left: 20%">모든 여행 상품 둘러보기</a>
            </div>
        </li>

        <li class="parent-board">커뮤니티</li>
        <li><a href="/user/community/together" class="child-title">같이 여행 가요!</a></li>
        <li><a href="/user/community/curious" class="child-title">여행에 대해 궁금해요.</a></li>

        <li class="parent-board">나의 여행</li>
        <li><a href="/user/mytravel/upcoming" class="child-title">곧 여기로 떠나요!</a></li>
        <li><a href="/user/mytravel/upcoming/payment" class="child-title" style="padding-left: 10%">이용 가능한 상품</a></li>
        <li><a href="/user/mytravel/upcoming/refund" class="child-title" style="padding-left: 10%">이용 불가능한 상품</a></li>
        <li><a href="/user/mytravel/interesting" class="child-title">이 여행지에 관심있어요.</a></li>

        <li class="parent-board">마이 페이지</li>
        <li><a href="/user/mypage/together" class="child-title">나의 '같이 여행 가요!'</a></li>
        <li><a href="/user/mypage/curious" class="child-title">나의 '여행에 대해 궁금해요.'</a></li>

        <%--    로그인 상태--%>
        <c:if test="${not empty pageContext.request.userPrincipal }">
            <li class="parent-board"><a href="/logout">로그아웃</a></li>
        </c:if>
    </ul>
</nav>
<script>
    $(document).ready(function() {
        /** 드롭다운 토글 */
        $(".dropdown-toggle").click(function() {
            // 드롭다운 메뉴 슬라이드 토글
            $(this).next(".dropdown-menu").slideToggle("fast");
        });

        // AJAX로 데이터 받아오기
        $.ajax({
            url: "/guest/all/tags",
            method: "GET",
            dataType: "json",
            success: function(data) {
                // 데이터를 받아왔으면 드롭다운 메뉴에 옵션을 추가
                var dropdownMenu = $(".dropdown-menu");
                // 데이터를 반복하면서 옵션을 생성하고 메뉴에 추가
                data.forEach(function(tag) {
                    var option = $("<a class='dropdown-item' href='/guest/all/products/tag?tag=" + tag.tag + "' style='margin-left: 20%;'>" + tag.tag + "</a>");
                    dropdownMenu.append(option);
                });
            },
            error: function(error) {
                console.error("에러 발생: " + error);
            }
        });
    });
</script>