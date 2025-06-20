package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.TodoDTO;

@Mapper
public interface TodoMapper {
        List<TodoDTO> getAllTodo();
        int insertTodo(TodoDTO todoDTO);
        int deleteTodo(int id);
        int updateTodo(TodoDTO todoDTO);
}
