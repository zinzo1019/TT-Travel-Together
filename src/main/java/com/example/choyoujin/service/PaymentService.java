package com.example.choyoujin.service;

import com.example.choyoujin.dao.PaymentDao;
import com.example.choyoujin.dao.TravelProductDao;
import com.example.choyoujin.dto.PaymentDto;
import com.example.choyoujin.dto.ProductDto;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

import static com.example.choyoujin.service.FileService.decompressBytes;
import static com.example.choyoujin.service.TravelProductServiceImpl.setImage;

@Service
public class PaymentService {

    @Autowired
    private PaymentDao paymentDao;
    @Autowired
    private UserService userService;
    @Autowired
    private TravelProductDao productDao;
    @Autowired
    private TravelProductServiceImpl productService;

    /** 여행 상품 결제건 저장하기 */
    public void savePayment(PaymentDto paymentDto) {
        try {
            paymentDao.savePayment(paymentDto); // 결제건 저장
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    /** 여행 상품 결제 취소하기 */
    public void cancelPaymentById(int id) {
        paymentDao.cancelPaymentById(id);
    }

    /** 사용자 아이디로 여행 상품 결제건 리스트 가져오기 */
    @NotNull
    public List<PaymentDto> findAllByUserId() {
        List<PaymentDto> paymentDtos = paymentDao.findAllByUserId(userService.getUserData().getId()); // 결제한 정보 리스트
        paymentDtos.stream().forEach(dto -> {
            ProductDto productDto = productDao.findProductByProductId(dto.getProductId()); // 여행 상품 Set
            productDto.setEncoding(decompressBytes(productDto.getPicByte())); // 이미지 Set
            dto.setProductDto(productDto);
        });
        return paymentDtos;
    }

    public void updateEnabledByProductId(int productId, boolean enabled) {
        try {
            paymentDao.updateEnabledByProductId(productId, enabled);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
