package com.example.choyoujin.service;

import com.example.choyoujin.dao.PaymentDao;
import com.example.choyoujin.dao.TravelProductDao;
import com.example.choyoujin.dto.PaymentDto;
import com.example.choyoujin.dto.ProductDto;
import com.example.choyoujin.dto.RefundDto;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import static com.example.choyoujin.service.FileService.decompressBytes;

@Service
public class PaymentServiceImpl implements PaymentService {

    @Value("${cid}")
    private String cid;
    @Value("${imp_key}")
    private String impKey;
    @Value("${imp_secret}")
    private String impSecret;
    @Autowired
    private PaymentDao paymentDao;
    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductDao productDao;

    /**
     * 여행 상품 결제건 저장하기
     */
    @Override
    public void savePayment(PaymentDto paymentDto) {
        try {
            paymentDao.savePayment(paymentDto); // 결제건 저장
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    /**
     * 여행 상품 결제 취소하기
     */
    @Override
    public void cancelPaymentById(int id) {
        paymentDao.cancelPaymentById(id);
    }

    /**
     * 사용자 아이디로 여행 상품 결제건 리스트 가져오기
     */
    @Override
    public List<PaymentDto> findAllByUserId() {
        List<PaymentDto> paymentDtos = paymentDao.findAllByUserId(userService.getUserData().getId()); // 결제한 정보 리스트
        paymentDtos.stream().forEach(dto -> {
            ProductDto productDto = productDao.findProductByProductId(dto.getProductId()); // 여행 상품 Set
            productDto.setEncoding(decompressBytes(productDto.getPicByte())); // 이미지 Set
            dto.setProductDto(productDto);
        });
        return paymentDtos;
    }

    /** 관리자 - 모든 여행 상품 결제건 가져오기 */
    @Override
    public List<PaymentDto> findAllPayments() {
        List<PaymentDto> paymentDtos = paymentDao.findAllPayments();
        System.out.println(paymentDtos);
        return paymentDtos;
    }

    /** 관리자 - 모든 여행 상품 환불건 가져오기 */
    @Override
    public List<RefundDto> findAllRefunds() {
        List<RefundDto> refundDtos = paymentDao.findAllRefunds();
        System.out.println(refundDtos);
        return refundDtos;
    }

    /**
     * 사용자 아이디와 이용 가능 여부로 여행 상품 결제건 리스트 가져오기
     */
    @Override
    public List<PaymentDto> findAllByUserIdAndAvailable(boolean available) {
        List<PaymentDto> paymentDtos = paymentDao.findAllByUserIdAndAvailable(userService.getUserData().getId(), available); // 결제한 정보 리스트
        paymentDtos.stream().forEach(dto -> {
            ProductDto productDto = productDao.findProductByProductId(dto.getProductId()); // 여행 상품 Set
            productDto.setEncoding(decompressBytes(productDto.getPicByte())); // 이미지 Set
            dto.setProductDto(productDto);
        });
        return paymentDtos;
    }

    /**
     * 여행 상품 사용 가능 여부 수정하기
     */
    @Override
    public void updateEnabledByProductId(int productId, boolean enabled) {
        try {
            paymentDao.updateEnabledByProductId(productId, enabled);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    /**
     * 여행 상품 사용 불가능 처리 - 사용 불가 사유
     */
    @Override
    public void updateEnabledByProductId(int paymentId, boolean enabled, String notAvailableReason) {
        try {
            paymentDao.updateNotAvailableByProductId(paymentId, enabled, notAvailableReason);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    /**
     * 환불 처리하기 - 환불 정보 저장하기
     */
    @Override
    public void saveRefund(RefundDto refundDto) {
        try {
            refundPayment(refundDto); // 카카오페이 화불
            paymentDao.saveRefund(refundDto); // 환불 정보 저장
            updateEnabledByProductId(refundDto.getPaymentId(), false, "환불된 상품입니다."); // 여행 상품 사용 불가능 처리
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    /**
     * 포트원 - 여행 상품 환불하기
     */
    @Override
    public void refundPayment(RefundDto refundDto) {
        try {
            PaymentDto paymentDto = paymentDao.findOneByPaymentId(refundDto.getPaymentId()); // 반품할 결제 데이터 가져오기

            MultiValueMap<String, Object> parameters = new LinkedMultiValueMap<>(); // 반품할 결제 데이터 담기
            parameters.add("cid", cid); // CID
            parameters.add("tid", paymentDto.getPgTid()); // TID
            parameters.add("cancel_request_amount", paymentDto.getPaidAmount()); // 환불액
            parameters.add("merchant_uid", paymentDto.getMerchantUid()); // 취소 비과세 금액
            parameters.add("reason", paymentDto.getReason()); // 환불 사유
            parameters.add("refund_holder", paymentDto.getUserName()); // 예금주
            parameters.add("refund_bank", 88); // 은행 코드
            parameters.add("refund_account", ""); // 수령 계좌번호

            String token = getAccessToken(); // 포트원 토큰 가져오기

            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "Bearer " + token); // 헤더에 토큰 담기
            HttpEntity<MultiValueMap<String, Object>> data = new HttpEntity<>(parameters, headers); // 포트원에 전송할 데이터 담기

            // 대상 서버로 데이터 전송
            String response = restTemplate.exchange(
                    "https://api.iamport.kr/payments/cancel",
                    HttpMethod.POST,
                    data,
                    String.class
            ).getBody();
            System.out.println("카카오페이 환불 처리를 완료했습니다.");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    /**
     * 포트원 - 토큰 발급
     */
    @Override
    public String getAccessToken() {
        MultiValueMap<String, Object> parameters = new LinkedMultiValueMap<>();
        parameters.add("imp_key", cid);
        parameters.add("imp_key", impKey);
        parameters.add("imp_secret", impSecret);

        RestTemplate restTemplate = new RestTemplate();
        HttpEntity<MultiValueMap<String, Object>> data = new HttpEntity<>(parameters); // 전송할 데이터
        ResponseEntity<String> responseEntity = restTemplate.exchange(
                "https://api.iamport.kr/users/getToken",
                HttpMethod.POST,
                data, // 요청 데이터
                String.class
        );
        String accessToken = null;
        String responseBody = responseEntity.getBody();
        ObjectMapper objectMapper = new ObjectMapper(); // Jackson ObjectMapper를 사용하여 JSON 파싱
        try {
            Map<String, Object> responseMap = objectMapper.readValue(responseBody, new TypeReference<Map<String, Object>>() {
            });
            accessToken = (String) ((Map<String, Object>) responseMap.get("response")).get("access_token");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return accessToken;
    }
}
