package edu.hanoi.jazz;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextStartedEvent;

public class ContextStartEventHandler implements ApplicationListener<ContextStartedEvent>{

	private final static Logger LOGGER = Logger.getLogger(ContextStartEventHandler.class);
	@Autowired
	private DataSource dataSource;
	
	@Override
	public void onApplicationEvent(ContextStartedEvent arg0) {
		LOGGER.info("context start application " + dataSource);
		try {
			createTable("HN_GROUP", "create table HN_GROUP(id bigint primary "
					+ " key generated always as identity(start with 1, increment by 1),"
					+ " name varchar(100))");
		} catch (Exception e) {
			
		}
	}

	private void createTable(String name, String script) throws SQLException {
		DatabaseMetaData dbmd = dataSource.getConnection().getMetaData();
		ResultSet rs = dbmd.getTables(null, null, name, null);
		if(rs.next()){
			LOGGER.info("Tables " + name + " already exists!");
			return;
		}
		dataSource.getConnection().createStatement().executeUpdate(script);
	}
}
