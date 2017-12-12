package edu.hanoi.jazz.dao.impl;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Component;

import edu.hanoi.jazz.dao.GroupDAO;
import edu.hanoi.jazz.dao.model.Group;

@Component("groupDAO")
public class GroupDAOImpl implements GroupDAO{
	
	@Autowired
	private LocalSessionFactoryBean sessionFactory;
	
	@Override
	public void insert(Group group) {
		Session session = sessionFactory.getObject().openSession();
		try {
			session.save(group);
			session.flush();
			Logger.getLogger(GroupDAOImpl.class).info("Save group " + group.getName() + " done!");
		} finally{
			session.close();
		}
	}
}
