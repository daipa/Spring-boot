package edu.java.restful.dao;

import org.springframework.stereotype.Component;

@Component
public class FibonacciDAO {

	public long getFibonacci(int n){
		if(n == 1 || n == 2) return 1;
		
		return getFibonacci(n - 1) + getFibonacci(n - 2);
	}
}
