<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Welcome to Spring Jazz</h1>
	<p><a href="/">Trang Chủ</a>
		<security:authorize access="!hasAnyRole('ROLE_USER')">
			<a href="/login">Đăng nhập</a>
		</security:authorize>
		<security:authorize access="hasAnyRole('ROLE_USER')">
			<a href="/nguoidung">Người dùng</a>
			<a href="javascript:document.getElementById('logout').submit();">Đăng xuất</a>
		</security:authorize>
	</p>
	<form action="/j_spring_security_logout" id="logout" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
	<tiles:insertAttribute name="body" />
</body>
</html>