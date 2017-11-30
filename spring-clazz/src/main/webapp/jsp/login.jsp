<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<tiles:insertDefinition name="template">
	<tiles:putAttribute name="body">
		<h1>Login to Application</h1>
		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<form method="post" action="/login">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
			<p>
				<input type="text" name="j_username"
					placeholder="Username" >
			</p>
			<p>
				<input type="password" name="j_password" 
					placeholder="Password" >
			</p>
			<p class="submit">
				<input type="submit" name="commit" value="Login">
			</p>
		</form>
	</tiles:putAttribute>
</tiles:insertDefinition>