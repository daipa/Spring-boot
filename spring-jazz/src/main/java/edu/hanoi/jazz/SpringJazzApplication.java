package edu.hanoi.jazz;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication
@ImportResource("classpath:config.xml")
public class SpringJazzApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringJazzApplication.class, args);
	}
}
