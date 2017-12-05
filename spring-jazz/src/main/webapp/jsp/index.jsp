<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertDefinition name="template">
	<tiles:putAttribute name="body">
		<h2>${message}</h2>
	</tiles:putAttribute>
</tiles:insertDefinition>