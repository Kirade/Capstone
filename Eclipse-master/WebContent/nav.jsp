<%@ page contentType ="text/html; charset=utf-8" %>
<%@page import="java.sql.*"%>
<!DOCTYPE html>

<%

 /* session timeout */
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

String query = "select idx, title, date, writer from announcement order by idx desc limit 4";
ResultSet rs  = stat.executeQuery(query);
%>


<html lang="en">
<jsp:include page="/navInclude.jsp"></jsp:include>

<body>

<div class="row" >	<!-- 홈 Bottom -->

	<div class="col-sm-4" style="margin:10px" >	
		<div class="table-responsive" style="overflow-x:auto; text-align:center;">
			<a class="main-bottom-subject">Announcement</a>
		
			<table class="table table-striped" id="entries-table" >
		      <tbody>
		<%
		while(rs.next()){
		  int idx = rs.getInt("idx");
		  String writer = rs.getString("writer");
		  String title = rs.getString("title");
		  String date = rs.getString("date");
		%>
		        <tr>
		          <td><a href="/announcement/announcement_show.jsp?idx=<%=idx%>"><%=title%></a></td> 
		          <td><%=writer %></td>
		          <td><%=date%></td>
		        </tr>
		<%
		}
		rs.close();
		stat.close();
		conn.close();
		}catch(Exception e){
		  throw new Exception(e);
		}
		%>
		      </tbody>
		    </table>
		    <a href="/announcement/announcement.jsp" style="float:right">more &gt;&gt;</a>  
		</div>

		
	</div>

	<div class="col-sm-4" style="margin:10px">
		<div style="text-align:center">
			<a class="main-bottom-subject">Schedules</a> <br />
			<b>Upcomming events</b> <br />
			<iframe src="https://calendar.google.com/calendar/embed?showTitle=0&amp;showNav=0&amp;showPrint=0&amp;showCalendars=0&amp;showTz=0&amp;mode=AGENDA&amp;height=150&amp;wkst=1&amp;bgcolor=%23FFFFFF&amp;src=f5ilm5a33fv5b93fk7r88iai0s%40group.calendar.google.com&amp;color=%23B1440E&amp;ctz=Asia%2FManila" 
style="border-width:0" height="160" frameborder="0" scrolling="no"></iframe>
		</div>
	</div>

	<div class="col-sm-3" style="margin:10px">
	  	<div style="text-align:center;" >
  			<a class="main-bottom-subject">Signed in as</a>
		  	<br>
		    ID: ${id}<br>
		    Name: ${name}<br>
		    User level: ${level}<br>
  		</div>
  	</div>
</div>

<div class="row">
	<div style="text-align:center;">
		<a style="color:grey; font-size:2vmin;"> Handong University Capstone Project</a>
	</div>
</div>
</body>
</html>
