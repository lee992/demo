package com.example.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.demo.model.Todo;
import com.example.demo.service.TodoService;

@RestController
@RequestMapping("/api/todos")
public class TodoController {

    @Autowired
    private TodoService service;

    @GetMapping
    public List<Todo> all() {
        return service.getAll();
    }

    @PostMapping
    public void add(@RequestBody Todo todo) {
        service.addTodo(todo);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable int id) {
        service.deleteTodo(id);
    }

    @PutMapping("/{id}")
    public void update(@PathVariable int id, @RequestBody Todo todo) {
        todo.setId(id);
        service.updateTodo(todo);
    }
}
