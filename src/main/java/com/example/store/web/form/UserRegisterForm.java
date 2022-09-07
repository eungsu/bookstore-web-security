package com.example.store.web.form;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import com.example.store.vo.User;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(of = {"email", "name", "tel"})
public class UserRegisterForm {

	@NotBlank(message = "이메일은 필수입력값입니다.")
	@Email(message = "유효한 이메일형식이 아닙니다.")
	private String email;
	
	@NotBlank(message =  "비밀번호는 필수입력값입니다.")
	@Pattern(regexp = "[a-zA-Z0-9]{8,20}", message = "유효한 비밀번호형식이 아닙니다.")
	private String password;
	
	@NotBlank(message = "이름은 필수입력값입니다.")
	@Pattern(regexp = "[가-힣]{2,}", message = "이름은 한글만 가능하며, 2글자 이상입니다.")
	private String name;
	
	@Pattern(regexp = "\\d{2,3}-\\d{3,4}-\\d{4}", message = "유효한 전화번호 형식이 아닙니다.")
	private String tel;
	
	public User formToUser() {
		User user = new User();
		user.setEmail(email);
		user.setPassword(password);
		user.setName(name);
		user.setTel(tel);
		
		return user;
	}
}
