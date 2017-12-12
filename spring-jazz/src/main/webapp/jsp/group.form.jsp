<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<tiles:insertDefinition name="template">
		<tiles:putAttribute name="body">
			<h1>Add Group</h1>
			<form:form action="/nhom/luu" method="post">
				<p><form:input type="text" path="name" /></p>
				<p><input type="submit" name="add" value="Add" > </p>
			</form:form>
		</tiles:putAttribute>
	</tiles:insertDefinition>
</body>
</html>