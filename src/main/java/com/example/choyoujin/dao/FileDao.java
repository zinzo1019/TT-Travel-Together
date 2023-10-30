package com.example.choyoujin.dao;

import com.example.choyoujin.dto.ImageDto;
import com.example.choyoujin.dto.ProductDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FileDao {
    void saveImage(ImageDto imageDto); // 이미지 저장하기
    int findLastImageId(); // 가장 마지막 이미지 아이디 가져오기
    void saveProductImage(ImageDto imageDto);
    int findLastTravelProductImageId();
    void updateImage(ImageDto imageDto);
}