package edu.java.restful.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import edu.java.restful.dao.FibonacciDAO;
import edu.java.restful.dao.StudentDAO;
import edu.java.restful.model.Fibonaci;
import edu.java.restful.model.Student;

@RestController
public class RestfulController {
	@Autowired
	private FibonacciDAO fibonaciDao;
	@Autowired
	private StudentDAO studentDao;
	
	@RequestMapping("/hello")
	public String hello(@RequestParam(value="id", required=false) String id){
		if(id != null) return "Hello " + id;
		return "Hello spring boot";
	}
	
	@RequestMapping("/fibonacci")
	public Fibonaci fibonacci(@RequestParam("n") int n){
		return new Fibonaci(n, fibonaciDao.getFibonacci(n));
	}
	
	@RequestMapping("/student")
	public Student student(@RequestParam("id") int id){
		return studentDao.getStudent(id);
	}
	
}
