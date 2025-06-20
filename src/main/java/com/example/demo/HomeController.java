package com.example.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.UserDTO;
import com.example.demo.service.UserService;
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
	private UserService userService;  //의존성 주입 - 필드주입
	
	@GetMapping("/Test")
	public String Test(Model model) {
		List<UserDTO> users = userService.getAllUser();
		model.addAttribute("users",users);
		return "DbTest";
	}
}
		
	
	
