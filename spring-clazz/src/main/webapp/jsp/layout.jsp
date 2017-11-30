<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Spring Boot Application</title>
</head>
<body>
	<table border="1" cellpadding="2" cellspacing="2" align="center">
		<tr>
			<td height="30" >Welcome to Java Spring Clazz
			</td>
		</tr>
		<tr>
			<td>
				<a href="/">Trang chủ</a>
				<sec:authorize access="!hasAnyRole('ROLE_USER')">
					<a href="/login" style="padding-left:30px;">Đăng nhập</a>
				</sec:authorize>
				<sec:authorize access="hasAnyRole('ROLE_USER')">
					<a href="/nguoi-dung">Cá nhân</a>
					<a href="/logout">Logout</a>
				</sec:authorize>
				
			</td>
		</tr>
		<tr>
			<td><tiles:insertAttribute name="body" /></td>
		</tr>
		
	</table>
</body>
</html>