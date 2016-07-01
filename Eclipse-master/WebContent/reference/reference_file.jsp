<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="com.oreilly.servlet.MultipartRequest" %>

<%
request.setCharacterEncoding("utf-8");
response.setContentType("utf-8");

MultipartRequest multi = null;
int sizeLimit=10*1024*1024; // 10MB
String savePath = request.getRealPath("/upload/");
try{
	multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
}catch(Exception e){
	e.printStackTrace();
}

int idx = Integer.parseInt(multi.getParameter("idx"));
String filename = multi.getFilesystemName("filename");
String title = multi.getParameter("title");
String writer = multi.getParameter("writer");
String type = multi.getParameter("type");
String date = multi.getParameter("date");
%>

<html lang="en">
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
	<jsp:forward page="/reference/reference_db_add.jsp">
		<jsp:param name="idx" value="<%=idx%>"/>
		<jsp:param name="title" value="<%=title%>"/>
		<jsp:param name="writer" value="<%=writer%>"/>
		<jsp:param name="type" value="<%=type%>"/>
		<jsp:param name="date" value="<%=date%>"/>
		<jsp:param name="filename" value="<%=filename%>"/>
	</jsp:forward>
</body>
</html>
