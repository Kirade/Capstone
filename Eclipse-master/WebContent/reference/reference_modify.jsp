
<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp" %>
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
String query = "select * from reference where idx="+idx;
ResultSet rs = stat.executeQuery(query);
if(rs.next())
{
  String type = rs.getString("type");
  String title = rs.getString("title");
  String writer = rs.getString("writer");
%>

<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>


<div class="container container-margin">
  <h2>Modify Reference Information</h2><br>

  <form method="post" action="/reference/reference_db_modify.jsp?idx=<%=idx%>">
    No. <%=idx%>
    <input type="hidden" name="idx" value="<%=idx%>"><br><br>

    <p><b>Writer</b> : ${name}</p>
    <input type="hidden" name="writer" value="${name}">

    <div class="form-group">
      <b> Date </b> : <%=date%>
      <input type="hidden" name="date" value="<%=date%>"><br></p>
      <label for="type">Type: </label><br>
      <%
      if(type.equals("Document form")){
      %>
      <input type="radio" name="type" value="Document form" checked>Document Form
      <input type="radio" name="type" value="Driver">Driver
      <%
    }else if(type.equals("Driver")){
      %>
      <input type="radio" name="type" value="Document-form">Document Form
      <input type="radio" name="type" value="Driver" checked>Driver
      <%
    }
    %>

    </div><br>
    <div class="form-group">
      <label for="Title">Title: </label>
      <input type="text" class="form-control" name="title" id="title" value="<%=title%>">
    </div><br>
    <div class="form-group">
      <label for="content">Attachment: </label>
      <textarea class="form-control" rows="10" id="content">
      </textarea>
    </div>
    <input type="submit" class="btn btn-primary" value="Save">
    <input type="reset" class="btn btn-primary" value="Reset">
    <a href="/reference/references.jsp"><button type="button" class="btn btn-primary">Back</button></a>
  </form>
</div>
</body>
</body>
<%
}
}catch(Exception e){
  throw new Exception(e);
}
%>

</html>
