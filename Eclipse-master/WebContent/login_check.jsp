<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp"%>
<%@page import="java.sql.*"%>

<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String[] remember = request.getParameterValues("remember");
	
	if(remember != null) {
		Cookie c = new Cookie("userid", id);
		c.setMaxAge(24*60*60);
		response.addCookie(c);
	}
	
	Boolean check = false;
	if(id==null || pwd==null)
	{
		throw new Exception("ID or Password 미입력");
	}

	Connection conn = null; // DB연결을 위한 변수
	Statement stat = null; // DB쿼리를 위한 변수
	String db_user = "admin";
	String db_pass = "dbadministrator";

	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test",db_user,db_pass);
		if(conn==null)
		{
			throw new Exception("DB 연결 에러");
		}
		stat = conn.createStatement();
		ResultSet rs = stat.executeQuery("select * from member");

		while(rs.next())
		{
			String db_id = rs.getString("id");
			String db_pwd = rs.getString("pwd");
			String db_name = rs.getString("name");
			String db_level = rs.getString("level");

			if(db_id.equals(id) && db_pwd.equals(pwd))
			{
				session.setAttribute("id",id);
				session.setAttribute("pwd",pwd);
				session.setAttribute("name",db_name);
				session.setAttribute("level",db_level);
				check = true;
			}
		}
	}
	catch(Exception e){
		throw e;
	}
	finally{
		try{
			stat.close();
		}
		catch(Exception ignore){
			//throw new Exception("stat.close() Error");
		}
		try{
		conn.close();
		}
		catch(Exception ignore){
			//throw new Exception("conn.close() Error");
		}
	}

	if(check){
		response.sendRedirect("/nav.jsp");
	}
	else{
%>

		<script>
		alert("login failed.");
		location.href = "/login.jsp";
		</script>
<%
	}
%>
