package com.example.choyoujin.dao;

import com.example.choyoujin.dto.CountryDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CountryDao {
    List<CountryDto> findAllCountries();
}
