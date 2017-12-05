package edu.java.restful.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import edu.java.restful.model.Student;

@Component
public class StudentDAO {
		
	public Student getStudent(int id){
		List<Student> students = new ArrayList<Student>();
		students.add(new Student(1, "Nguyen Van A", "20"));
		students.add(new Student(2, "Nguyen Van B", "21"));
		students.add(new Student(3, "Nguyen Van C", "22"));
		
		for(int i = 0; i < students.size(); i++){
			if(id == students.get(i).getId()) return students.get(i);
		}
		
		return null;
	}
}
