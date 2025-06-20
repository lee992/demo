package com.example.demo.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.TodoMapper;
import com.example.demo.model.TodoDTO;

@Service
// Service layer for todo operations
public class TodoService{
        @Autowired
        private TodoMapper todoMapper;
	
        /*
         * Example of constructor injection:
         * private TodoService(TodoMapper todoMapper) {
         *     this.todoMapper = todoMapper;
         * }
         */
        public List<TodoDTO> getAllTodo(){
                return todoMapper.getAllTodo();
        }
        public int insertTodo(TodoDTO todoDTO) {
                return todoMapper.insertTodo(todoDTO);
        }
        public int deleteTodo(int id) {
                return todoMapper.deleteTodo(id);
        }
        public int updateTodo(TodoDTO todoDTO) {
                return todoMapper.updateTodo(todoDTO);
        }
	
}
