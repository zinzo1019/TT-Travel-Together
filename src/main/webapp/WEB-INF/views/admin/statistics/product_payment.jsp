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
<title>통계 - 결제 건수</title>
<style>
    .content {
        margin-left: 15%; /* 네비게이션 바의 넓이와 일치하도록 설정 */
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
        max-width: 3000px;
    }

    .chart-container {
        display: flex;
    }

    .paymentChart {
        flex: 1.4;
    }

    .percentage {
        flex: 0.6;
    }
</style>
<body>
<div class="content">
    <div class="main-container">
        <div>
            <h1>월별 결제 건수</h1>
            <div class="chart-container">
                <div class="paymentChart">
                    <canvas id="paymentChart"></canvas>
                </div>
                <div class="percentage">
                    <canvas id="percentageChart"></canvas>
                </div>
            </div>
        </div>
        <div style="display: flex; gap: 20px; margin-top: 5%;">
            <div style="flex: 1; width: 100%;">
                <h1>나라별 결제 건수</h1>
                <div style="width: 100%;">
                    <canvas id="barChart"></canvas>
                </div>
            </div>
            <div style="flex: 1; width: 100%;">
                <h1>여행 상품별 결제 건수</h1>
                <div style="width: 100%;">
                    <canvas id="barChart2"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $.ajax({
        url: 'paymentChart',
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
            var ctx = document.getElementById('paymentChart').getContext('2d');
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: dates,
                    datasets: [{
                        label: '결제 건수',
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

    /** 결제 & 환불 퍼센티지 */
    var ctx = document.getElementById('percentageChart').getContext('2d');
    var paymentPercentage = ${paymentRefundRate.payment}; // 모델로 전달된 payment 퍼센티지
    var refundPercentage = ${paymentRefundRate.refund}; // 모델로 전달된 refund 퍼센티지
    var data = {
        labels: ["결제", "환불"],
        datasets: [{
            data: [paymentPercentage, refundPercentage],
            backgroundColor: ["#f84444", "#fa986d"] // 색상 설정
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

    /** 나라별 결제 건수 */
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
                    label: '결제 건수',
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

        /** 여행 상품별 결제 건수 */
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
                    label: '결제 건수',
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
                            callback: function(value, index, values) {
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
