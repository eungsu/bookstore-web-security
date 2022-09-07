package com.example.store.security;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.store.vo.User;
import com.example.store.mapper.UserMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	private final UserMapper userMapper;
	
	// 인증에 필요한 사용자정보를 조회해서 UserDetails 인터페이스 구현객체(이 애플리케이션에서는 User객체다)로 반환한 메소드
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		// User객체는 id, email, password, name, tel, point, disabled, createdDate, updatedDate, role, authorities를 가진다.
		// User객체의 role 변수에는 "ROLE_USER" 문자열이 저장된다.
		// User객체의 authorities는 null이다.		
		User user = userMapper.getUserByEmail(email);
		if (user == null) {
			new UsernameNotFoundException("존재하지 않는 회원입니다.");
		}
		// User객체의 authorities에 Collection<GrandedAuthority> 객체가 저장된다.
		Collection<? extends GrantedAuthority> authorities = this.getAuthorities(user.getRole());
		user.setAuthorities(authorities);
		
		// User객체는 UserDetails 인터페이스를 구현한 객체다.
		// User객체는 사용자정보(아이디, 이메일, 비밀번호 등)와 사용자가 보유한 접근권한정보를 포함하고 있다.
		return user;
	}
	
	// 사용자가 보유한 권한정보로 SimpleGrantedAuthority객체를 생성해서 List객체 담아서 반환하는 메소드다.
	private Collection<? extends GrantedAuthority> getAuthorities(String role) {
		return List.of(new SimpleGrantedAuthority(role));
	}
}
