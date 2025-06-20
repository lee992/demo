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

import com.example.demo.model.UserDTO;
import com.example.demo.service.UserService;

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
	private UserService userService;  //의존성 주입 - 필드주입
	
	@GetMapping("/Test")
	public String Test(Model model) {
		List<UserDTO> users = userService.getAllUser();
		model.addAttribute("users",users);
		return "DbTest";
	}
	
	@PostMapping("InsertTest")
	public String InsertTest(UserDTO userDTO) {
		userService.InsertTest(userDTO);
		return"redirect:/Test";
	}
	
	@GetMapping("/DeleteTest")
	public String DeleteTest(@RequestParam int id) {
		userService.DeleteTest(id);
		return "redirect:/Test";
	}
	
	@GetMapping("/CrystalTest")
	public String CrystalTest(

		@RequestParam("id") int id,
		@RequestParam("test") String test
){	
	UserDTO dto = new UserDTO();
	//System.out.println(dto.getId());
	//System.out.println(dto.getTest());
    dto.setId(id);
    dto.setTest(test);
    userService.CrystalTest(dto);
    return "redirect:/Test";
}
}
		
	
	
