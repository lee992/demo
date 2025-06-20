package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.UserDTO;

@Mapper
public interface UserMapper {
	List<UserDTO> getAllUser();
}