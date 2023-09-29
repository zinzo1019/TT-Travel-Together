<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <style>
        /* 기본 여백 제거 */
        body {
            margin: 0;
            padding: 0; /* 추가로 body의 padding도 제거해 주세요. */
        }

        header {
            position: fixed; /* 고정 위치 설정 */
            top: 0; /* 맨 위에 고정 */
            left: 0;
            right: 0; /* 화면 전체 너비로 확장 */
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #333;
            color: white;
            z-index: 1000; /* 다른 요소 위에 레이어 표시 */
        }

        /* 왼쪽 서비스 이름 스타일 */
        .service-name {
            font-size: 24px;
            font-weight: bold;
        }

        /* 오른쪽 환영 메시지 스타일 */
        .welcome-message {
            font-size: 16px;
        }
    </style>
</head>
<body>
<header>
    <div class="service-name"> TT | Travel Together </div>
    <div class="welcome-message">조유진님, 반갑습니다!</div>
</header>
</body>

