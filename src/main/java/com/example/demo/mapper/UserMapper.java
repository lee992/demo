package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.UserDTO;

@Mapper
public interface UserMapper {
	List<UserDTO> getAllUser();
	int InsertTest(UserDTO userDTO);
	int DeleteTest(int id);
	int CrystalTest(UserDTO userDTO);
}