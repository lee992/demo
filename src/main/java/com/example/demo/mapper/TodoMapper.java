package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Todo;

@Mapper
public interface TodoMapper {
    List<Todo> getAll();
    int insert(Todo todo);
    int delete(int id);
    int update(Todo todo);
}
