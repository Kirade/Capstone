<%@page contentType="application/vnd.ms-excel;charset=utf-8" errorPage="/Error.jsp"%> 
<%@page import="java.sql.*"%>
<% 
    //중요한 사항 : "attachment; filename=excel.xls" 로 적으면 excel.xls 파일이 생성되고 다운로드된다. 
    //모든 HTML은 Excel 파일형식으로 변환됨 (편하지 않나요?)  
    response.setHeader("Content-Disposition", "attachment; filename=excel.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data"); 
    
	String memberId = (String)session.getAttribute("id");
	boolean login = memberId == null ? false : true;
	if(!login) {
	  response.sendRedirect("/login.jsp");
	}

	request.setCharacterEncoding("utf-8");
	response.setContentType("utf-8");
	String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
	String db_user="admin";
	String db_pwd="dbadministrator";
	
	Connection conn = null;
	Statement stat = null;
	
	try{
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(db_url,db_user,db_pwd);
	if(conn==null)
	{
	  throw new Exception("DB 연결 Error");
	}
	stat = conn.createStatement();
	
	String query = "select * from student"; // 학생 정보 얻어오기위한 쿼리 저장
	ResultSet rs = stat.executeQuery(query);

%>
<html>
<head>
<title>Excel Download</title>
</head>
<body bgcolor=white>
	<table border=1>
	<tr></tr>
	<tr bgcolor="#CACACA">
		<th></th>
		<th>S_NO</th>
		<th>Name</th>
		<th>Gender</th>
		<th>Address</th>
		<th>Birth</th>
		<th>E_Mail</th>
		<th>Location</th>
		<th>Comment</th>
	</tr>
<%
   while(rs.next()) {    
%>        
	<tr>
		<td> </td>
		<td><%=rs.getString("s_no")%></td>
		<td><%=rs.getString("name")%></td>
		<td><%=rs.getString("gender")%></td>
		<td><%=rs.getString("address")%></td>
		<td><%=rs.getString("birth")%></td>
		<td><%=rs.getString("e_mail")%></td>
		<td><%=rs.getString("location")%></td>
		<td><%=rs.getString("comment")%></td>
	</tr>
<% 
} //while
rs.close();
stat.close();
conn.close();
}catch(Exception e) {
	throw new Exception(e);
}
		
%>
</table>
</body>
</html>