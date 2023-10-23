package com.example.choyoujin.service;

import com.example.choyoujin.dao.TagDao;
import com.example.choyoujin.dto.TagDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagService {

    @Autowired
    private TagDao tagDao;

    /** 여행 상품 아이디로 태그 리스트 찾기 */
    public List<TagDto> findAllByProductId(int productId) {
        return tagDao.findAllByProductId((productId));
    }

    /** 아이디로 태그 삭제하기 */
    public void deleteOneById(int id) {
        tagDao.deleteOneById(id);
    }

    /**
     * 모든 여행 태그 가져오기
     */
    public List<TagDto> findAll() {
        return tagDao.findAll();
    }
}
