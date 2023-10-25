package com.example.choyoujin.service;

import com.example.choyoujin.dao.UserDao;
import com.example.choyoujin.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;

import static com.example.choyoujin.service.FileService.decompressBytes;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private FileService fileService;
    @Autowired
    private BCryptPasswordEncoder pwdEncoder;

    /**
     * 로그인한 사용자 정보 가져오기
     */
    public UserDto getUserData() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            String email = ((UserDetails) principal).getUsername();
            UserDto userDto = findUserByEmail(email);
            userDto.setEncoding(decompressBytes(userDto.getPicByte())); // 이미지 압축 해제
            return userDto;
        }
        return null;
    }

    public UserDto findUserByEmail(String email) {
        return userDao.findUserByEmail(email);
    }

    /**
     * 사용자 저장
     */
    public void saveUser(UserDto userDto, String role, int enabled, int imageId) {
        try {
            userDto.setCreateDate(LocalDate.now()); // 생성 날짜
            userDto.setPassword(pwdEncoder.encode(userDto.getPassword())); // 암호화
            userDao.saveUser(userDto, role, enabled, imageId); // 사용자 저장
        } catch (Exception e) {
            System.out.println(e.getMessage());
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
        try {
            if (!userDto.getImage().isEmpty())
                imageId = fileService.saveImage(userDto.getImage());// 이미지 저장
        } catch (IOException e) {
            System.out.println("이미지 업로드를 실패했습니다.");
        }
        return imageId;
    }

    /**
     * 게시글 작성자와 로그인자 비교
     */
    public boolean compareWriterAndUser(int writerId) {
        if (writerId == getUserData().getId()) return true;
        else return false;
    }

    /** 사용자 여행 태그 수정하기 */
    public void updateTravelTag(String travelTag) {
        int userId = getUserData().getId();
        userDao.updateTravelTag(userId, travelTag);
    }
}
