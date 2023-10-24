package com.example.choyoujin.dao;

import com.example.choyoujin.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserDao {
    List<UserDto> list();
    UserDto findUserByEmail(String email);
    void saveUser(UserDto userDto, String role, int enabled, int imageId);
    void updateTravelTag(int userId, String travelTag);
}
