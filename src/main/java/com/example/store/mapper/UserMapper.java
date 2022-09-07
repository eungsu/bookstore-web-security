package com.example.store.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.store.vo.User;

@Mapper
public interface UserMapper {
    
	User getUserByEmail(String email);
	User getUserById(int id);
	void insertUser(User user);
	void updateUser(User user);
}
