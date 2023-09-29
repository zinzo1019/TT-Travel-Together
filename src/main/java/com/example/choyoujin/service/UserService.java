package com.example.choyoujin.service;

import com.example.choyoujin.dao.UserDao;
import com.example.choyoujin.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private FileService fileService;
    @Autowired
    private BCryptPasswordEncoder pwdEncoder;

    /** 사용자 저장 */
    public boolean saveUser(UserDto userDto, String role, int enabled, int imageId) {
        // 회원가입 날짜
        LocalDate createDate = LocalDate.now();
        userDto.setCreateDate(createDate);
        if (isUser(userDto.getEmail()) == false) {
            // 암호화
            String pwd = pwdEncoder.encode(userDto.getPassword());
            userDto.setPassword(pwd);
            // 사용자 저장
            userDao.saveUser(userDto, role, enabled, imageId);
            System.out.println("사용자를 저장했습니다.");
            return true; // 첫 회원가입
        } else {
            System.out.println("이미 회원가입된 사용자입니다.");
            return true; // 이미 가입된 회원
        }
    }

    /**
     * 이미 회원가입한 사용자인지 확인
     */
    public boolean isUser(String email) throws UsernameNotFoundException {
        try { // 회원가입 했다면
            UserDto userDto = userDao.findUserByEmail(email);
            System.out.println(userDto.getEmail());
            return true;
        } catch (Exception e) { // 회원가입 안 했다면
            return false;
        }
    }

    /**
     * 사용자 이미지 저장하기
     */
    public int saveImageAndGetImageId(UserDto userDto) {
        int imageId = 0;
        if (userDto.getImage() != null && !userDto.getImage().isEmpty()) {
            try {
                /** 사진 업로드 */
                if (!userDto.getImage().isEmpty()) {
                    imageId = fileService.saveImage(userDto.getImage());// 이미지 저장
                }
            } catch (IOException e) {
                System.out.println("이미지 업로드를 실패했습니다.");
            }
        } else {
            System.out.println("이미지를 선택하지 않았습니다.");
        }
        return imageId;
    }

}
