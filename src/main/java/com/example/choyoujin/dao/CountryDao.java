package com.example.choyoujin.dao;

import com.example.choyoujin.dto.CountryDto;
import com.example.choyoujin.dto.ProductDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CountryDao {
    List<CountryDto> findAllCountries();
    int countAllContries();
    List<CountryDto> findAllCountriesOrderByLike(int page, int size);
    CountryDto findCountryByCountryId(int countryId);
    int countAllCountriesByKeyword(String keyword);
    List<CountryDto> findAllCountriesByKeyword(String keyword, int page, int size);
    List<ProductDto> find4CountriesByCountryLike();
}
