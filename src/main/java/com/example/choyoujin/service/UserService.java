package com.example.choyoujin.service;

import com.example.choyoujin.dao.UserDao;
import com.example.choyoujin.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
            if (userDto == null)
                return false;
            else return true;
        } catch (Exception e) {
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
        if (writerId == getUserData().getUserId()) return true;
        else return false;
    }

    /** 사용자 여행 태그 수정하기 */
    public void updateTravelTag(String travelTag) {
        int userId = getUserData().getUserId();
        userDao.updateTravelTag(userId, travelTag);
    }

    /** 관리자 회원가입 - 사용자 저장하기 */
    public ResponseEntity<String> saveUser(UserDto userDto, String role) {
        if (validateSaveUser(userDto)) {
            int imageId = saveImageAndGetImageId(userDto); // 이미지 저장
            saveUser(userDto, role, 1, imageId); // 사용자 저장
            return ResponseEntity.ok("");
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(""); // 회원가입 실패
    }

    /** 회원가입 - 유효성 검사 */
    public boolean validateSaveUser(UserDto userDto) {
        if (userDto == null) {
            System.out.println("사용자 데이터가 없습니다.");
            return false; // 사용자 데이터가 없는 경우
        }

        // 이메일 유효성 검사
        if (userDto.getEmail() == null || userDto.getEmail().isEmpty()) {
            System.out.println("사용자 이메일이 없습니다.");
            return false; // 이메일 필드가 비어있는 경우
        } else {
            String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
            Pattern pattern = Pattern.compile(emailRegex);
            Matcher matcher = pattern.matcher(userDto.getEmail());
            if (!matcher.matches()) {
                System.out.println("이메일 형식이 맞지 않습니다.");
                return false; // 유효한 이메일 형식이 아닌 경우
            }
        }

        // 비밀번호 강도 검사 (예: 최소 8자, 대/소문자 및 숫자 포함)
        if (userDto.getPassword() == null || userDto.getPassword().length() < 8) {
            System.out.println("비밀번호가 8자 미만입니다.");
            return false; // 비밀번호가 8자 미만인 경우
        }
        if (!Pattern.compile("[a-z]").matcher(userDto.getPassword()).find() || // 소문자
                !Pattern.compile("[A-Z]").matcher(userDto.getPassword()).find() || // 대문자
                !Pattern.compile("[0-9]").matcher(userDto.getPassword()).find() || // 숫자
                !Pattern.compile("[!@#$%^&*()_+\\-=\\[\\]{};':\",.<>/?\\\\|]").matcher(userDto.getPassword()).find()) {
            System.out.println("비밀번호는 대소문자 / 숫자 / 특수문자를 모두 포함해주세요.");
            return false;
        }

        // 이메일 중복 검사
        if (isUser(userDto.getEmail())) {
            System.out.println("중복된 아이디입니다.");
            return false;
        }
        return true;
    }
}








