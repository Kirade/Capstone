
<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp" %>
<%@page import="java.sql.*"%>

<%
request.setCharacterEncoding("utf-8");
response.setContentType("utf-8");
String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
String db_user="admin";
String db_pwd="dbadministrator";
int idx = Integer.parseInt(request.getParameter("idx"));

Connection conn = null;
Statement stat = null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(db_url, db_user, db_pwd);
    if(conn == null){
      throw new Exception("DB 연결 error");
    }
    stat = conn.createStatement();

    String query = "select * from announcement where idx="+idx;
    ResultSet rs = stat.executeQuery(query);

    if(rs.next()){
      String title=rs.getString("title");
      String writer = rs.getString("writer");
      String date = rs.getString("date");
      String content = rs.getString("content");
%>
<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>


<div class="container container-margin">


  <h2>Announcement</h2>
  <p>
    <h3>Title: </h3>
    <div class="well well-sm">
      <%=title%>
    </div>
    <b>Date: </b> <%=date%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    <b>Writer: </b> <%=writer %><br><br>
    <div class="well well-lg">
      <%=content%>
    </div>
    <a href="/announcement/announcement.jsp"><button type="button" class="btn btn-default">Back</button></a>
    <button type="button" class="btn btn-default" onclick="location.href='/announcement/announcement_modify.jsp?idx=<%=idx%>'">
    <span class="glyphicon glyphicon-edit"></span>Modify</button>
    <button type="button" class="btn btn-danger" onclick="location.href='/announcement/announcement_db_delete.jsp?idx=<%=idx%>'">
    <span class="glyphicon glyphicon-trash"></span>Delete</button>
  </p>
</div>
</body>
<%
}
}catch(Exception e){
  throw new Exception(e);
}
%>
</html>
