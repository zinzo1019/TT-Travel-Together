<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    /* 푸터 스타일 */
    footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        background-color: #333;
        color: white;
        padding: 10px;
    }

    p {
        margin: 5px 0; /* 위아래 마진을 5px로 설정 */
    }

    /* 왼쪽 컨텐츠 스타일 */
    .left-content {
        text-align: left;
        margin-right: auto; /* 오른쪽으로 공백을 주기 위해 추가 */
    }

    /* 오른쪽 컨텐츠 스타일 */
    .right-content {
        text-align: right;
        margin-left: auto; /* 왼쪽으로 공백을 주기 위해 추가 */
        padding-right: 5%; /* 오른쪽 여백 추가 */
    }

    .right-a {
        text-decoration: underline; /* 밑줄 추가 */
        color: white; /* 텍스트 색상 설정 */
    }

</style>
<footer>
    <div class="left-content">
        <p>TT | Travel Together</p>
        <p>writer | YOUJIN CHO</p>
        <p>email | topjoy22@naver.com</p>
    </div>
    <div class="right-content">
        <a href="#" class="right-a"><p>저희 사이트를 평가해주세요!</p></a>
    </div>
</footer>