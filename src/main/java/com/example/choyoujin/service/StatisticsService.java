package com.example.choyoujin.service;

import com.example.choyoujin.dao.PaymentDao;
import com.example.choyoujin.dto.ProductDto;
import com.example.choyoujin.dto.RefundDto;
import com.example.choyoujin.dto.StatisticsDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.Month;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StatisticsService {

    @Autowired
    private PaymentDao paymentDao;
    @Autowired
    private SqlSession sqlSession;
    @Autowired
    private TravelProductServiceImpl productService;

    /**
     * 달별 결제 건수 가져오기
     */
    public List<Map<String, Object>> countPaymentByMonth() {
        List<Map<String, Object>> pastMonths = findPastMonths(6);
        List<Map<String, Object>> chartData = sqlSession.selectList("com.example.choyoujin.dao.PaymentDao.countPaymentByMonth");
        chartData.stream().forEach(map -> {
            pastMonths.stream().forEach(month -> {
                if (map.get("month").equals(month.get("month"))) {
                    month.put("count", map.get("count"));
                }
            });
        });
        return pastMonths;
    }

    /**
     * 달별 환불 건수 가져오기
     */
    public List<Map<String, Object>> countRefundByMonth() {
        List<Map<String, Object>> pastMonths = findPastMonths(6);
        List<Map<String, Object>> chartData = sqlSession.selectList("com.example.choyoujin.dao.PaymentDao.countRefundByMonth");
        chartData.stream().forEach(map -> {
            pastMonths.stream().forEach(month -> {
                if (map.get("month").equals(month.get("month"))) {
                    month.put("count", map.get("count"));
                }
            });
        });
        return pastMonths;
    }

    /**
     * now를 기준으로 numberOfMonths 개수의 년도와 월을 리스트로 반환
     */
    public List<Map<String, Object>> findPastMonths(int numberOfMonths) {
        List<String> pastMonths = new ArrayList<>();
        // 현재 날짜의 년도와 월 정보 가져오기
        int currentYear = LocalDate.now().getYear();
        Month currentMonth = LocalDate.now().getMonth();
        // 현재 월부터 numberOfMonths 개수만큼 이전 월을 찾아서 리스트에 추가
        for (int i = 0; i < numberOfMonths; i++) {
            pastMonths.add(String.valueOf(YearMonth.of(currentYear, currentMonth))); // 리스트에 년도와 월을 추가
            currentMonth = currentMonth.minus(1); // 이전 월로 이동
            if (currentMonth == Month.JANUARY) { // 현재 월이 1월이면 년도도 이전으로 이동
                currentYear--;
                currentMonth = Month.DECEMBER;
            }
        }
        List<Map<String, Object>> datas = new ArrayList<>();
        pastMonths.stream().forEach(month -> {
            Map<String, Object> map = new HashMap<>();
            map.put("month", month);
            map.put("count", 0);
            datas.add(map);
        });
        return datas;
    }

    /**
     * 결제 환불 퍼센티지
     */
    public Map<String, Double> calculPaymentRate() {
        int paymentsCount = paymentDao.countPaymentBy6Month(); // 6개월 간 결제 건수
        int refundsCount = paymentDao.countRefundBy6Month(); // 6개월 간 환불 건수

        // 퍼센티지 계산
        double payment = 0.0;
        double refund = 0.0;
        if (paymentsCount > 0) {
            refund = (double) refundsCount / paymentsCount * 100.0;
            payment = 100.0 - refund;
        }

        Map<String, Double> percentageMap = new HashMap<>();
        percentageMap.put("payment", payment);
        percentageMap.put("refund", refund);
        return percentageMap;
    }

    /**
     * 여행 상품별 결제 건수 가져오기
     */
    public String countPaymentsByProduct() throws JsonProcessingException {
        List<StatisticsDto> statisticsDto = paymentDao.countPaymentsByProduct();
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(statisticsDto);
    }

    /**
     * 여행 상품별 환불 건수 가져오기
     */
    public String countRefundsByProduct() throws JsonProcessingException {
        List<StatisticsDto> statisticsDto = paymentDao.countRefundsByProduct();
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(statisticsDto);
    }

    /**
     * 나라별 결제 건수 가져오기
     */
    public String countPaymentsByCountry() throws JsonProcessingException {
        List<StatisticsDto> statisticsDto = paymentDao.countPaymentsByCountry();
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(statisticsDto);
    }

    /**
     * 나라별 환불 건수 가져오기
     */
    public String countRefundsByCountry() throws JsonProcessingException {
        List<StatisticsDto> statisticsDto = paymentDao.countRefundsByCountry();
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(statisticsDto);
    }

    /** 환불된 여행 상품 리스트 가져오기 */
    public List<RefundDto> findAllProductsByRefund() {
        List<RefundDto> refundDtos = paymentDao.findAllProductsByRefund();
        refundDtos.stream().forEach(refundDto -> {
            refundDto.setProductDto(productService.findProductByProductId(refundDto.getProductId()));
        });
        return refundDtos;
    }

    /** 환불 사유 리스트 가져오기 */
    public List<String > findAllRefundReasonByRefund() {
        return paymentDao.findAllRefundReasonByRefund();
    }
}
