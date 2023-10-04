package com.example.choyoujin.dao;

import com.example.choyoujin.dto.DetailDto;

import java.util.List;

public interface DetailDao {
    List<DetailDto> findallByProductId(int productId);
}
