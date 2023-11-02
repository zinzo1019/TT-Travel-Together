<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
<title>통계 - 환불 건수</title>
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
        margin-top: 3%;
    }

    .chart-container {
        display: flex;
    }

    .refundChart {
        flex: 1.4;
    }

    .percentage {
        flex: 0.6;
    }

    .product-img {
        border-radius: 10px;
        height: 300px;
    }

    .product-img img {
        width: 100%;
        height: 220px;
        border-radius: 10px 10px 0 0;
    }

    .product-info {
        text-align: left;
        padding: 5px;
        height: 110px;
        position: relative;
    }

    .img-container {
        display: flex;
        gap: 30px;
        height: 320px;
    }

    .shadowed {
        flex: 0.25;
        text-decoration: none;
        color: inherit;
        border: 0;
        box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.5);
        border-radius: 10px;
    }

    .refund-reason {
        background-color: #f2f2f2; /* 배경색 지정 */
        padding: 10px; /* 여백 추가 */
        border-radius: 5px; /* 테두리 둥글게 만들기 */
        border: 1px solid #ddd; /* 테두리 스타일과 색 지정 */
    }

    .refund-reason li {
        list-style: none; /* 리스트 항목의 기본 점 스타일을 없앱니다. */
        margin: 5px 0; /* 위아래 여백을 조정합니다. */
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <h1>환불 통계</h1>
        <div class="chart-container">
            <div class="refundChart">
                <canvas id="refundChart"></canvas>
            </div>
            <div class="percentage">
                <canvas id="percentageChart"></canvas>
            </div>
        </div>
        <div style="display: flex; gap: 20px; margin-top: 5%;">
            <div style="flex: 1; width: 100%;">
                <h1>나라별 환불 건수</h1>
                <div style="width: 100%;">
                    <canvas id="barChart"></canvas>
                </div>
            </div>
            <div style="flex: 1; width: 100%;">
                <h1>여행 상품별 환불 건수</h1>
                <div style="width: 100%;">
                    <canvas id="barChart2"></canvas>
                </div>
            </div>
        </div>
        <div style="display: flex; gap: 20px; margin-top: 5%;">
            <div style="flex: 1; width: 100%;">
                <h1>환불된 여행 상품</h1>
                <div class="img-container" style="height: 300px;">
                    <c:forEach var="refundDto" items="${refundProducts}">
                        <a href="/guest/product/detail?product_id=${refundDto.productDto.travelProductId}" class="shadowed">
                            <div class="product-img" style="display: inline-block; width: 100%;">
                                <img src="data:${refundDto.productDto.type};base64,${refundDto.productDto.encoding}"
                                     class="img-fluid">
                                <div class="product-info">
                                    <p style="font-size: small; color: red; margin-bottom: 0;">${refundDto.productDto.country}
                                        - ${refundDto.productDto.city}</p>
                                    <p style="margin-top: 0; font-weight: bold;">${refundDto.productDto.name}</p>
                                    <p style="font-weight: normal; font-size: medium; margin-bottom: 1px">
                                    </p>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div style="margin-top: 7%;">
            <h1>환불 사유</h1>
            <div style="width: 400px; height: 400px;">
                <!-- 차트를 그릴 캔버스 요소 -->
                <canvas id="myChart"></canvas>
            </div>
        </div>
    </div>
</div>
<script>
    $.ajax({
        url: 'refundChart',
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            var dates = [];
            var counts = [];

            // 받은 데이터를 배열에 저장
            for (var i = 0; i < data.length; i++) {
                dates.push(data[i].month);
                counts.push(data[i].count);
            }
            dates.reverse();
            counts.reverse();

            // 차트 생성
            var ctx = document.getElementById('refundChart').getContext('2d');
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: dates,
                    datasets: [{
                        label: '환불 건수',
                        data: counts,
                        backgroundColor: 'rgba(192,75,96,0.2)',
                        borderColor: 'rgb(192,75,102)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        },
        error: function () {
            console.error('데이터를 불러오는 중 오류가 발생했습니다.');
        }
    });

    var refundData = ${refundReasons};

    var refundLabels = refundData.map(function (item) {
        return item.refundReason;
    });
    var refundDoubles = refundData.map(function (item) {
        return item.refundDouble;
    });


    // 차트를 그릴 캔버스 요소 가져오기
    var ctx = document.getElementById('myChart').getContext('2d');

    // 차트 생성
    var myChart = new Chart(ctx, {
        type: 'doughnut', // 원형 차트
        data: {
            labels: refundLabels, // 레이블
            datasets: [{
                data: refundDoubles, // 데이터
                backgroundColor: [ // 색상 설정 (커스터마이즈 가능)
                    'rgba(255, 99, 132, 0.8)',
                    'rgba(54, 162, 235, 0.8)',
                    'rgba(255, 206, 86, 0.8)',
                    'rgba(75, 192, 192, 0.8)',
                    'rgba(153, 102, 255, 0.8)'
                ],
            }]
        },
    });

    var ctx = document.getElementById('percentageChart').getContext('2d');

    var paymentPercentage = ${paymentRefundRate.payment}; // 모델로 전달된 payment 퍼센티지
    var refundPercentage = ${paymentRefundRate.refund}; // 모델로 전달된 refund 퍼센티지

    var data = {
        labels: ["결제", "환불"],
        datasets: [{
            data: [paymentPercentage, refundPercentage],
            backgroundColor: ["#fa986d", "#f84444"] // 색상 설정
        }]
    };

    var options = {
        responsive: true
    };

    var myChart = new Chart(ctx, {
        type: 'doughnut',
        data: data,
        options: options
    });

    /** 나라별 환불 건수 */
    $(document).ready(function () {
        var data = ${countByContries};
        var labels = data.map(function (item) {
            return item.name;
        });
        var counts = data.map(function (item) {
            return item.count;
        });

        // 최대 값과 최소 값 계산
        var maxValue = Math.max(...counts);
        var minValue = 0;

        // 그래프 생성
        var ctx = document.getElementById('barChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: '환불 건수',
                    data: counts,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        max: maxValue, // 최대 값
                        min: minValue, // 최소 값
                        stepSize: 1, // Y축 간격을 1로 설정
                    }
                }
            }
        });

        /** 여행 상품별 환불 건수 */
        var data = ${countByProducts};
        var labels = data.map(function (item) {
            return item.name;
        });
        var counts = data.map(function (item) {
            return item.count;
        });

        // 최대 값과 최소 값 계산
        var maxValue2 = Math.max(...counts);
        var minValue2 = 0;

        // 그래프 생성
        var ctx2 = document.getElementById('barChart2').getContext('2d');
        var myChart2 = new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: '환불 건수',
                    data: counts,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    x: {
                        display: true,
                        ticks: {
                            callback: function (value, index, values) {
                                var label = labels[index];
                                return label.length > 5 ? label.substring(0, 5) + '...' : label;
                            }
                        }
                    },
                    y: {
                        beginAtZero: true,
                        max: maxValue2, // 최대 값
                        min: minValue2, // 최소 값
                        stepSize: 1 // Y축 간격을 1로 설정
                    }
                }
            }
        });
        // 막대 그래프의 너비를 고정
        myChart.data.datasets[0].barThickness = 30; // 조절하고 싶은 너비 값 (픽셀)
        myChart.update();
        myChart2.data.datasets[0].barThickness = 30; // 조절하고 싶은 너비 값 (픽셀)
        myChart2.update();
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
