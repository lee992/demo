package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.TodoMapper;
import com.example.demo.model.Todo;

@Service
public class TodoService {
    @Autowired
    private TodoMapper mapper;

    public List<Todo> getAll() {
        return mapper.getAll();
    }

    public int addTodo(Todo todo) {
        return mapper.insert(todo);
    }

    public int deleteTodo(int id) {
        return mapper.delete(id);
    }

    public int updateTodo(Todo todo) {
        return mapper.update(todo);
    }
}
