
<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp"%>
<%@page import="java.sql.*"%>

<%
	request.setCharacterEncoding("utf-8");
    response.setContentType("utf-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String address = request.getParameter("address");
    String e_mail = request.getParameter("e_mail");
    String location = request.getParameter("location");

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

	String query = String.format("UPDATE student set name := '%s', gender := '%s', address := '%s', e_mail := '%s', location := '%s' where s_no = %s;",name,gender,address,e_mail,location,idx);
	int rowNum = stat.executeUpdate(query);

	if(rowNum <1)
	{
		throw new Exception("DB 데이터를 수정하는 데 실패하였습니다.");
	}
	else
	{
		response.sendRedirect("/student/student_administration.jsp");
	}
	}catch(Exception e)
	{
		throw new Exception(e);
	}
%>
