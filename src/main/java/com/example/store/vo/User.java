package com.example.store.vo;

import java.util.Collection;
import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("User")
public class User implements UserDetails {
	
    private static final long serialVersionUID = -6388635655390422517L;
    
	private int id;
    private String email;
    private String password;
    private String name;
    private String tel;
    private int point;
    private String disabled;
    private Date createdDate;
    private Date updatedDate;
    private String role;
    private Collection<? extends GrantedAuthority> authorities;		// 회원이 보유하고 잇는 권한

    @Override
	public String getUsername() {
		return email;
	}
    
	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public boolean isEnabled() {
		return disabled.equals("N");
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
}
