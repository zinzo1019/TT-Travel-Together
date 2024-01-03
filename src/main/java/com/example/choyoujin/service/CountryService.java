package com.example.choyoujin.service;

import com.example.choyoujin.dao.CountryDao;
import com.example.choyoujin.dto.CountryDto;
import com.example.choyoujin.dto.NewsDto;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class CountryService {

    @Autowired
    private CountryDao countryDao;

    /**
     * 모든 여행지 가져오기 - 페이징 처리
     */
    public Page<CountryDto> findAllCountriesOrderByLike(int page, int size) {
        int start = (page - 1) * size + 4;
        List<CountryDto> productDtos = countryDao.findAllCountriesOrderByLike(start, size);
        int total = countryDao.countAllContries();
        return new PageImpl<>(productDtos, PageRequest.of(page -1, size), total);
    }

    /**
     * 모든 나라 데이터 가져오기
     */
    public List<CountryDto> findAllCountries() {
        return countryDao.findAllCountries();
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

    /** 나라별 기사 크롤링 */
    public List<NewsDto> crawlNaverNewsHeadlines(String country) {
        String url = "https://www.donga.com/news/search?query=" + country;
        List<NewsDto> newsDtos = new ArrayList<>();
        try {
            Document doc = Jsoup.connect(url).get();
            Elements headlines = doc.select(".articleList .tit a");

            for (int i = 0; i < 5; i++) {
                String title = headlines.get(i).attr("data-ep_button_name");
                String href = headlines.get(i).attr("href");

                NewsDto newsDto = NewsDto.builder()
                        .title(title)
                        .url(href)
                        .build();
                newsDtos.add(newsDto);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        return newsDtos;
    }
}
