package edu.java.restful.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import edu.java.restful.model.Fibonaci;

@RestController
public class RestfulController {
	
	@RequestMapping("/hello")
	public String hello(@RequestParam(value="id", required=false) String id){
		if(id != null) return "Hello " + id;
		return "Hello spring boot";
	}
	
	@RequestMapping("/fibonacci")
	public Fibonaci fibonacci(@RequestParam("n") int n){
		return new Fibonaci(n, getFibonacci(n));
	}
	
	public long getFibonacci(int n){
		if(n == 1 || n == 2) return 1;
		
		return getFibonacci(n - 1) + getFibonacci(n - 2);
	}
	
	
}
