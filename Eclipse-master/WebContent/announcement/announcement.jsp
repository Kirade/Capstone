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

int last_idx = 0;
int totalArticleCount = 0;

Connection conn = null;
Statement stat = null;

try{
Class.forName("com.mysql.jdbc.Driver");
conn=DriverManager.getConnection(db_url,db_user,db_pwd);
  if(conn==null)
    throw new Exception("DB 연결 Error");

stat = conn.createStatement();

String query = "select max(idx) from announcement";
ResultSet rs = stat.executeQuery(query);
if(rs.next()){
  last_idx = rs.getInt(1);
}
rs.close();

query = "select count(*) from announcement";
rs = stat.executeQuery(query);
if(rs.next()){
  totalArticleCount = rs.getInt(1);
}
rs.close();

query = "select lpad(idx,5,0) as idx, title, writer, date, content from announcement order by idx desc";
rs  = stat.executeQuery(query);
%>

<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>


<div class="container container-margin">

  <h2>Announcement</h2>
  <br>
  <br>
  <br>
  <br>
    <table class="table table-striped" id="entries-table">
      <thead>
        <tr>
          <th>No.</th>  
          <th data-priority="1">Title</th> 
          <th>Writer</th> 
          <th data-priority="2">Date</th> 
        </tr>
      </thead>
      <tbody>
<%
while(rs.next()){
  int idx = rs.getInt("idx");
  String title = rs.getString("title");
  String writer = rs.getString("writer");
  String date = rs.getString("date");
  String content = rs.getString("content");
%>
        <tr>
          <td><%=idx%></td> 
          <td ><a href="/announcement/announcement_show.jsp?idx=<%=idx%>"><%=title%></a></td> 
          <td><%=writer%></td> 
          <td><%=date%></td>
        </tr>
<%
}

%>
      </tbody>
    </table>
    
    <div class="edit">
      <a href="/announcement/announcement_write.jsp?last_idx=<%=last_idx%>"><button type="button" class="btn btn-default">
        <span class="glyphicon glyphicon-pencil"></span>Write</button></a>
    </div>
</div>
<%
rs.close();
stat.close();
conn.close();
}catch(Exception e){
  throw new Exception(e);
}

%>

<script type="text/javascript">

	$(document).ready(function() {
		var table = $("#entries-table").dataTable({
			searching: true,
			info: false,
			paging: true,
			ordering: false,
			responsive: true
		});
	})
	
</script>
</body>
</html>
