
<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp"%>
<%@page import="java.sql.*"%>

<%

	request.setCharacterEncoding("utf-8");
    response.setContentType("utf-8");
  
	int idx = Integer.parseInt(request.getParameter("idx"));
	String sn = request.getParameter("sn");
	String name = request.getParameter("name");
    String location = request.getParameter("location");
    int m_no = Integer.parseInt(request.getParameter("m_no"));

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

	String query = String.format("UPDATE asset set sn := '%s', name := '%s', location := '%s', m_no := '%d' where a_no = %d;",sn,name,location,m_no,idx);
	int rowNum = stat.executeUpdate(query);

	if(rowNum <1)
	{
		throw new Exception("DB 데이터를 수정하는 데 실패하였습니다.");
	}
	else
	{
		response.sendRedirect("/asset/asset_administration.jsp");
	}
	}catch(Exception e)
	{
		throw new Exception(e);
	}
%>