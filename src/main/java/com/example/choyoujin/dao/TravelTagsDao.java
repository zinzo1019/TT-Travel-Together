package com.example.choyoujin.dao;

import com.example.choyoujin.dto.TagDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TravelTagsDao {
    List<TagDto> findAllTags();
    void saveTags(List<String> tags);
    TagDto findOneByTag(String tag);
}
