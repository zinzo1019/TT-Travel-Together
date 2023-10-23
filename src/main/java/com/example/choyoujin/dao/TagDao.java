package com.example.choyoujin.dao;

import com.example.choyoujin.dto.TagDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TagDao {
    List<TagDto> findAllByProductId(int productId);
    void deleteOneById(int id);
    List<TagDto> findAll();
}
