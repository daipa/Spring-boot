package edu.hanoi.controller;

import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

	private final static Logger LOGGER = Logger.getLogger(HomeController.class);
	
//	@RequestMapping("/")
//	public @ResponseBody String home(){
//		return "Hello java clazz";
//	}
	
	@RequestMapping("/")
	public ModelAndView home(){
		ModelAndView mv = new ModelAndView("index");
		mv.addObject("message","Hello java clazz");
		LOGGER.info("Da vao day");
		return mv;
	}
	
	@RequestMapping("/login")
	public ModelAndView login(@RequestParam(value="error", required=false) String error){
		ModelAndView mv = new ModelAndView("login");
		mv.addObject("error", "Sai tên hoặc mật khẩu");
		return mv;
	}
	
	@RequestMapping("/nguoi-dung")
	public ModelAndView forUser(){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		ModelAndView mv = new ModelAndView("index");
		mv.addObject("message", "Hello user " + auth.getName());
		return mv;
	}
}
