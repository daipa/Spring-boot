package edu.hanoi.jazz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

	@RequestMapping("/")
	public ModelAndView home(){
		return new ModelAndView("index", "message", "Hello hihi");
	}
	
	@RequestMapping("/nguoidung")
	public ModelAndView forUser(){
		return new ModelAndView("index", "message", "This is protected page!");
	}
	
	@RequestMapping("/dangnhap")
	public ModelAndView login(@RequestParam(value="error", required=false) String error){
		ModelAndView mv = new ModelAndView("login");
		if(error != null) mv.addObject("error", error);
		return mv;
	}
}
