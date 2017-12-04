package edu.java.restful.model;

public class Fibonaci {
	private int n;
	private long fibonacci;
	
	public int getN() {
		return n;
	}
	public void setN(int n) {
		this.n = n;
	}
	public long getFibonacci() {
		return fibonacci;
	}
	public void setFibonacci(long fibonacci) {
		this.fibonacci = fibonacci;
	}
	public Fibonaci(int n, long fibonacci) {
		super();
		this.n = n;
		this.fibonacci = fibonacci;
	}
}
