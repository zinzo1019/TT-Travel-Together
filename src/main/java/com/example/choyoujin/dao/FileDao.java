package com.example.choyoujin.dao;

import com.example.choyoujin.dto.ImageDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FileDao {
    void saveImage(ImageDto imageDto); // 이미지 저장하기

    ImageDto findImageById(int id); // 기본키로 이미지 가져오기

    int findIdByEmail(String email); // 이메일로 사용자 이미지 아이디 가져오기

    int findLastImageId(); // 가장 마지막 이미지 아이디 가져오기
}