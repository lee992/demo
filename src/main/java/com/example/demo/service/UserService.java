package com.example.demo.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.UserMapper;
import com.example.demo.model.UserDTO;

@Service
//빨간줄이 뜨는 경우는 써야한다는 강제성을 주기 떄문
public class UserService implements UserMapper{
	@Autowired
	private UserMapper userMapper;
	
	/*
	 * private UserService(UserMapper useMapper) { this.userMapper=userMapper; }//
	 * 생성자 주입
	 */
	public List<UserDTO> getAllUser(){
		return userMapper.getAllUser();
	}
	
}
