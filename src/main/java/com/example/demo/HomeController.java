package com.example.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.TodoDTO;
import com.example.demo.service.TodoService;

import ch.qos.logback.core.net.SyslogOutputStream;
import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
@Controller
public class HomeController {
	@RequestMapping(value= "/home")
	@ResponseBody
	public String Home() {	
		return "Hello Spring Boot";
	}
	
	@RequestMapping(value="/homehtml")
	public String Homehtml() {
		return "Home";
	}
	
	@GetMapping("/TestJsp")
	public String Jsp() {
		return "Test";
	}
	
	@Autowired
        private TodoService todoService;  // 의존성 주입 - 필드주입
	
	@GetMapping("/Test")
        public String Test(Model model) {
                List<TodoDTO> todos = todoService.getAllTodo();
                model.addAttribute("todos", todos);
                return "DbTest";
       }
	
	@PostMapping("InsertTest")
        public String InsertTest(TodoDTO todoDTO) {
                todoService.insertTodo(todoDTO);
                return"redirect:/Test";
       }
	
	@GetMapping("/DeleteTest")
        public String DeleteTest(@RequestParam int id) {
                todoService.deleteTodo(id);
                return "redirect:/Test";
       }
	
	@GetMapping("/CrystalTest")
        public String CrystalTest(

		@RequestParam("id") int id,
		@RequestParam("test") String test
){	
        TodoDTO dto = new TodoDTO();
	//System.out.println(dto.getId());
	//System.out.println(dto.getTest());
    dto.setId(id);
    dto.setTest(test);
    todoService.updateTodo(dto);
    return "redirect:/Test";
}
}
		
	
	
