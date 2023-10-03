<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../base_view/header.jsp" %>
<%@ include file="../base_view/navigation.jsp" %>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>여행에 대해 궁금해요!</title>
<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- datepicker 라이브러리 추가 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
        bottom: 4%;
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
                    <h1>같이 여행 가요!</h1>
                </div>
            </div>
        </div>

        <div class="background-container" style="margin-top: 4%">
            <div class="country-container">
                <label>어느 나라로 갈까요?</label>
                <select id="options" name="options">
                    <c:forEach items="${options}" var="option">
                        <option value="${option.country}-${option.city}">
                                ${option.country} - ${option.city}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>언제 갈까요?</label>
                <input type="text" id="start-date" placeholder="날짜 선택" readonly>
                <input type="text" id="end-date" placeholder="날짜 선택" readonly>
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>몇 명을 모집할까요?</label>
                <input type="number" id="recruitedNum" placeholder="0에서 300 사이 숫자 입력">
            </div>
            <div class="country-container" style="margin-top: 3%">
                <label>언제까지 모집할까요?</label>
                <input type="text" id="deadline" placeholder="날짜 선택" readonly>
            </div>
        </div>
        <div class="background-container" style="margin-top: 4%; padding-bottom: 4%">
            <label for="title" class="label">제목</label>
            <input type="text" id="title" name="title" required>
            <label for="content" class="label">내용</label>
            <textarea id="content" required></textarea><br><br>
            <button class="search-button" id="submitButton">작성하기</button>
        </div>
    </div>
</div>
<script>
    /** 어느 나라로 갈까요? */
    const selectBox = document.getElementById("options");
    selectBox.addEventListener("change", () => {
        // 선택한 값을 가져옴
        const selectedValue = selectBox.value;
        console.log("선택한 값: " + selectedValue);
    });

    /** 날짜 */
    $(function () {
        // 시작 날짜 선택
        $("#start-date").datepicker({
            dateFormat: "yy-mm-dd", // 날짜 형식 설정 (예: 2023-09-30)
            onSelect: function (dateText) {
                // 선택한 날짜를 텍스트 필드에 설정
                $("#start-date").val(dateText);
            }
        });

        // 끝 날짜 선택
        $("#end-date").datepicker({
            dateFormat: "yy-mm-dd", // 날짜 형식 설정 (예: 2023-09-30)
            onSelect: function (dateText) {
                // 선택한 날짜를 텍스트 필드에 설정
                $("#end-date").val(dateText);
            }
        });

        // 모집 마감 날짜
        $("#deadline").datepicker({
            dateFormat: "yy-mm-dd", // 날짜 형식 설정 (예: 2023-09-30)
            onSelect: function (dateText) {
                // 선택한 날짜를 텍스트 필드에 설정
                $("#deadline").val(dateText);
            }
        });
    });

    /** 모집 인원 - 0 ~ 300명 */
    var recruitedNum = document.getElementById('recruitedNum');
    recruitedNum.addEventListener('input', function () {
        var inputValue = parseFloat(recruitedNum.value);
        // 값이 0 이상 300 이하인지 확인
        if (inputValue < 0 || inputValue > 300) {
            alert('모집 인원은 0명 이상 300명 이하입니다.');
            recruitedNum.value = '';
        }
    });

    /** 제출 버튼 클릭 - 유효성 검사 */
    var submitButton = document.getElementById('submitButton');
    submitButton.addEventListener('click', function () {
        event.preventDefault(); // 기본 동작 중단
        var countryValue = document.getElementById('options').value;
        var startDateValue = document.getElementById('start-date').value;
        var endDateValue = document.getElementById('end-date').value;
        var recruitedNumValue = parseFloat(document.getElementById('recruitedNum').value);
        var deadlineValue = document.getElementById('deadline').value;
        var titleValue = document.getElementById('title').value;
        var contentValue = document.getElementById('content').value;

        // 현재 날짜 가져오기
        var currentDate = new Date();
        // 날짜 형식의 문자열을 Date 객체로 변환
        var startDate = new Date(startDateValue);
        var endDate = new Date(endDateValue);
        var deadline = new Date(deadlineValue);

        if (!countryValue) {
            alert('어느 나라로 갈지 선택하세요.');
            return false;
        }
        if (!startDateValue) {
            alert('출발 날짜를 선택하세요.');
            return false;
        }
        if (!endDateValue) {
            alert('도착 날짜를 선택하세요.');
            return false;
        }
        if (!recruitedNumValue) {
            alert('인원 수를 입력하세요.');
            return false;
        }
        if (!deadlineValue) {
            alert('마감일을 선택하세요.');
            return false;
        }
        if (deadlineValue < 0 || deadlineValue > 300) {
            alert('모집 인원은 0명 이상 300명 이하입니다.');
            recruitedNum.value = '';
            return false;
        }
        if (!titleValue) {
            alert('제목을 입력하세요.');
            return false;
        }
        if (!contentValue) {
            alert('내용을 입력하세요.');
            return false;
        }
        if (startDateValue > endDateValue) {
            alert('시작 날짜는 종료 날짜보다 이후일 수 없습니다.');
            return false;
        }
        if (startDate < currentDate) {
            alert('시작 날짜는 현재 날짜보다 이전일 수 없습니다.');
            return false;
        }
        if (endDate < currentDate) {
            alert('종료 날짜는 현재 날짜보다 이전일 수 없습니다.');
            return false;
        }
        if (deadline < currentDate) {
            alert('모집 마감 날짜는 현재 날짜보다 이전일 수 없습니다.');
            return false;
        }

        else { // 게시글 저장
            var formData = new FormData();
            formData.append("country", countryValue); // 나라
            formData.append("startDate", startDateValue); // 시작 날짜
            formData.append("endDate", endDateValue); // 종료 날짜
            formData.append("recruitedNum", recruitedNumValue); // 모집 인원
            formData.append("deadline", deadlineValue); // 마감 날짜
            formData.append("title", titleValue); // 제목
            formData.append("content", contentValue); // 제목
            $.ajax({
                type: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                success: function (data) {
                    alert('게시글이 작성되었습니다.');
                },
                error: function (error) {
                    alert('게시글 작성에 실패했습니다.');
                }
            });
        }
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
