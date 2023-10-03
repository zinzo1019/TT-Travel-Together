package com.example.choyoujin.service;

import com.example.choyoujin.dao.CountryDao;
import com.example.choyoujin.dto.CountryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.List;

@Service
public class CountryService {

    @Autowired
    private CountryDao countryDao;

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
}
