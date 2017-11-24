package edu.hanoi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	@RequestMapping("/")
	public @ResponseBody String home(){
//		ModelAndView mv = new ModelAndView("index");
//		mv.addObject("message", "Hello java clazz");
		return "Hello java clazz";
	}
}
