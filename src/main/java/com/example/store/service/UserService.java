package com.example.store.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.store.exception.AlreadyUsedEmailException;
import com.example.store.exception.LoginFailureException;
import com.example.store.mapper.UserMapper;
import com.example.store.vo.User;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserService {

	private final PasswordEncoder passwordEncoder;
	private final UserMapper userMapper;
	
	public void addNewUser(User user) {
		User savedUser = userMapper.getUserByEmail(user.getEmail());
		if (savedUser != null) {
			throw new AlreadyUsedEmailException("이미 사용중인 이메일입니다.");
		}
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		userMapper.insertUser(user);
	}

	public User login(String email, String password) {
		User savedUser = userMapper.getUserByEmail(email);
		if (savedUser == null) {
			throw new LoginFailureException("이메일 혹은 비밀번호가 일치하지 않습니다.");
		}
		if ("Y".equals(savedUser.getDisabled())) {
			throw new LoginFailureException("탈퇴처리된 계정입니다.");
		}
		if (!savedUser.getPassword().equals(password)) {
			throw new LoginFailureException("이메일 혹은 비밀번호가 일치하지 않습니다.");
		}
		return savedUser;
	}
}
