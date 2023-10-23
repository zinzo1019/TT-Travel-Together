<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<h1 style="margin-top: 5%">아래 쿠폰을 찾으시나요?</h1>
<c:forEach var="coupon" items="${coupons}">
    <div class="coupon-container">
        <p style="font-size: small; color: red">
            [${coupon.country} - ${coupon.city}] ${coupon.productName}
        </p>
        <div>
            <p style="font-size: large; font-weight: bold; margin-bottom: 1%">
                    ${coupon.name}
            </p>
            <p style="font-size: medium; margin-bottom: 2%;">${coupon.description}</p>
            <p class="discount">
                <c:choose>
                    <c:when test="${coupon.amount > 0}">
                        <strong>할인 금액:</strong> ${coupon.amount} 할인
                    </c:when>
                    <c:when test="${coupon.percentage > 0}">
                        <strong>할인 퍼센트:</strong> ${coupon.percentage}% 할인
                    </c:when>
                    <c:otherwise>
                        <strong>할인 없음</strong>
                    </c:otherwise>
                </c:choose>
            </p>
            <p style="font-size: medium"><strong>쿠폰 코드: </strong>${coupon.code}</p>
        </div>
        <div class="edit-button">
            <button class="modify-button" data-coupon-id="${coupon.id}">수정</button>
            <button class="delete-button" data-coupon-id="${coupon.id}">삭제</button>
        </div>
    </div>
</c:forEach>
<script>
    /** 쿠폰 수정 혹은 삭제 버튼 클릭 */
    $(document).ready(function () {
        // 수정 버튼 클릭 이벤트 핸들러
        $(document).ready(function () {
            $(".modify-button").click(function () {
                var couponId = $(this).data("coupon-id"); // 데이터 속성에서 쿠폰 ID를 가져옵니다.
                window.location.href = "update?coupon_id=" + couponId;
            });
        });

        // 삭제 버튼 클릭 이벤트 핸들러
        $(".delete-button").click(function () {
            var couponId = $(this).data("coupon-id");
            $.ajax({
                type: "POST",
                url: "delete?coupon_id=" + couponId,
                success: function (data) {
                    alert("쿠폰을 삭제했습니다.");
                    window.location.reload();
                },
                error: function () {
                    alert("쿠폰 삭제에 실패했습니다.");
                }
            });
        });
    });
</script>
</body>
</html>
<%@ include file="../base_view/footer.jsp" %>
