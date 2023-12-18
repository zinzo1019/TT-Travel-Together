package com.example.choyoujin.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatDao {
    void saveChatRoom();
}
