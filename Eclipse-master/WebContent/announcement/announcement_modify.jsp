<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<%
request.setCharacterEncoding("utf-8");
response.setContentType("utf-8");
String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
String db_user="admin";
String db_pwd="dbadministrator";
int idx = Integer.parseInt(request.getParameter("idx"));
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
Date d = new Date();
String date = format.format(d);
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
String query = "select * from announcement where idx="+idx;
ResultSet rs = stat.executeQuery(query);
if(rs.next())
{
  String title = rs.getString("title");
  String writer = rs.getString("writer");
  String content = rs.getString("content");
%>

<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>


  <div class="container container-margin">


    <h2>Modify Announcement Information</h2>
    <p>
    <form method="post" action="/announcement/announcement_db_modify.jsp?idx=<%=idx%>">
      No. <%=idx%><br>
      <input type="hidden" class="form-control" name="idx" value="<%=idx%>">
      <b>Date</b>: <%=date%> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      <input type="hidden" class="form-control" name="date" value="<%=date%>">
      
      <b>Writer</b> : ${name}
      <input type="hidden" class="form-control" name="writer" value="${name}"><br>
      
      <label for="title">Title: </label>
      <input type="text" class="form-control" name="title" value="<%=title%>">
      
      <label for="content">Content: </label>
      <textarea class="form-control" rows="10" id="content" name="content"><%=content%></textarea>
      
      <input type="submit" class="btn btn-primary" value="Save">
      <input type="reset" class="btn btn-primary" value="Reset">
      <a href="/announcement/announcement.jsp"><button type="button" class="btn btn-primary">Back</button></a>
    </form>
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
