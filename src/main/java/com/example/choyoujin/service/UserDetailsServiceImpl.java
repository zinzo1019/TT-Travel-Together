package com.example.choyoujin.service;

import com.example.choyoujin.dao.UserDao;
import com.example.choyoujin.dto.UserDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private final UserDao userDao;

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        UserDto userDto = userDao.findUserByEmail(email);
        return toUserDetails(userDto);
    }

    private UserDetails toUserDetails(UserDto userDto) {
        return User.builder()
                .username(userDto.getEmail())
                .password(userDto.getPassword())
                .authorities(new SimpleGrantedAuthority(userDto.getRole()))
                .build();
    }
}