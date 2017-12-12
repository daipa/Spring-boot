package edu.hanoi.jazz.controller;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import edu.hanoi.jazz.dao.GroupDAO;
import edu.hanoi.jazz.dao.model.Group;

@Controller
@RequestMapping("/nhom")
public class GroupController {
	
	@Autowired
	private GroupDAO groupDAO;
	
	@RequestMapping("/them")
	public ModelAndView addForm(){
		return new ModelAndView("group.form", "command", new Group());
	}
	
	@RequestMapping(value="/luu", method=RequestMethod.POST)
	public ModelAndView addNew(@Valid @ModelAttribute("command") Group group, BindingResult result){
		if(result.hasErrors()){
			ModelAndView mv = new ModelAndView("group.form", "command", group);
			mv.addObject("errors", result);
			return mv;
		}
		
		Logger.getLogger(GroupController.class).info("add new group ---> " + group);
		groupDAO.insert(group);
		return new ModelAndView("group.form");
	}
}
