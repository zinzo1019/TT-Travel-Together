package com.example.choyoujin.service;

import com.example.choyoujin.dao.DetailDao;
import com.example.choyoujin.dto.DetailDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DetailService {

    @Autowired
    private DetailDao detailDao;

    /** 여행 상품 아이디로 설명 리스트 가져오기 */
    public List<DetailDto> findAllByProductId(int productId) {
        return detailDao.findAllByProductId(productId);
    }

    /** 여행 상품 아이디로 설명 리스트 삭제하기 */
    public void deleteAllByProductId(int productId) {
        detailDao.deleteAllByProductId(productId);

    }

    /** 아이디로 설명 삭제하기 */
    public void deleteOneById(int id) {
        detailDao.deleteOneById(id);
    }
}
