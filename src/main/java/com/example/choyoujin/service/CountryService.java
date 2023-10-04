package com.example.choyoujin.service;

import com.example.choyoujin.dao.CountryDao;
import com.example.choyoujin.dto.CountryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.List;

@Service
public class CountryService {

    @Autowired
    private CountryDao countryDao;

    /**
     * 최근 뜨는 여행지 제외 모든 여행지 가져오기 - 페이징 처리
     */
    public Page<CountryDto> findAllCountriesExcept4(int page, int size) {
        int start = (page - 1) * size;
        List<CountryDto> productDtos = countryDao.findAllCountriesExcept4(start, size);
        int total = countryDao.countAllContries();
        return new PageImpl<>(productDtos, PageRequest.of(page -1, size), total);
    }

    /**
     * 모든 나라 데이터 가져오기
     */
    public List<CountryDto> findAllCountries() {
        return countryDao.findAllCountries();
    }

    /** 모든 나라 데이터 모델에 담기 */
    public void getCountriesAndAddModel(Model model) {

        model.addAttribute("options", findAllCountries());
    }
    /** 모든 나라 개수 세기  */
    public int countAllCountries() {
        return countryDao.countAllContries();
    }

    /** 나라 아이디로 나라 데이터 가져오기 */
    public CountryDto findCountryByCountryId(int countryId) {
        return countryDao.findCountryByCountryId(countryId);
    }

    /** 나라 이름으로 검색된 결과 개수 */
    public int countAllCountriesByKeyword(String keyword) {
        return countryDao.countAllCountriesByKeyword(keyword);
    }

    /** 나라 이름으로 검색된 결과 */
    public Page<CountryDto> findAllCountriesByKeyword(String keyword, int page, int size) {
        int start = (page - 1) * size;
        List<CountryDto> countryDtos = countryDao.findAllCountriesByKeyword(keyword, start, size);
        int total = countryDao.countAllCountriesByKeyword(keyword);
        return new PageImpl<>(countryDtos, PageRequest.of(page -1, size), total);
    }
}
