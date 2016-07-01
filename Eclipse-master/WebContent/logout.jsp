<%@ page contentType ="text/html; charset=utf-8" %>
<% 
	session.removeAttribute("id");
	response.sendRedirect("/login.jsp"); 
%>
