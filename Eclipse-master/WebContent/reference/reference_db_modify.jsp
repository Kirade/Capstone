<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
request.setCharacterEncoding("utf-8");
response.setContentType("utf-8");

SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
Date d = new Date();
String date = format.format(d);

int idx = Integer.parseInt(request.getParameter("idx"));
String type=request.getParameter("type");
String title = request.getParameter("title");
String writer = request.getParameter("writer");

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

String query = String.format("UPDATE reference set type := '%s', title := '%s', writer := '%s', date := '%s' where idx = %s;",type, title, writer, date,idx);
int rowNum = stat.executeUpdate(query);

if(rowNum <1)
{
  throw new Exception("DB 데이터를 수정하는 데 실패하였습니다.");
}
else
{
  response.sendRedirect("/reference/references.jsp");
}
}catch(Exception e)
{
  throw new Exception(e);
}
%>
