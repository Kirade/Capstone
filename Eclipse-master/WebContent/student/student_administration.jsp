<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp" %>
<%@page import="java.sql.*"%>

<%	/* DB 세팅 */
	request.setCharacterEncoding("utf-8");
	response.setContentType("utf-8");
	String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
	String db_user="admin";
	String db_pwd="dbadministrator";
	
	int total=0;  // 총 학생 수 구할 때, 사용 할 변수
	int s_id=0; // 마지막 학번 저장
	
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
	
	
	String  query = "select max(s_no) from student";
	ResultSet  rs = stat.executeQuery(query);

	if(rs.next())
		s_id = rs.getInt(1); // 마지막 학번을 저장.
	rs.close();
		
	query = "select count(*) from student";
	rs = stat.executeQuery(query);
	
	if(rs.next())
		total = rs.getInt(1);

	query = "select lpad(s_no,5,0) as s_id ,name,gender,address,birth,e_mail,location from student"; // 학생 정보 얻어오기위한 쿼리 저장
	rs = stat.executeQuery(query);


%>

<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>

	<div class="container container-margin">
		<div id="print_table">
			<h2>Student Information</h2>
			<br>
			<%
			out.print("Total : "+total);
			%>
			<br>
			<a href=/student/stu_excel.jsp>Save as MS-Excel</a>
			<br>
			<br>
		
			<table class="table table-striped" id="student-table">
			  <thead>
			    <tr>
			      <th data-priority="1">Student ID</th>
			      <th data-priority="1">Name</th>
			      <th>Gender</th>
			      <th>Address</th>
			      <th>E-Mail</th>
			      <th>Location</th>
			      <th></th>
			    </tr>
			  </thead>
			  <tbody>
				<%
				if(total==0){
				%>
			   <tr>
			     <td colspan="7">No student information.</td>
			   </tr>
				<%
				}else{
				  while(rs.next()){
				    int idx = rs.getInt("s_id");
				    String name = rs.getString("name");
				    String gender = rs.getString("gender");
				    String address = rs.getString("address");
				    String e_mail = rs.getString("e_mail");
				    String location = rs.getString("location");
				%>
			
			   <tr>
			     <td ><%=idx%></td>
			     <td ><%=name%></td>
			     <td><%=gender%></td>
			     <td><%=address%></td>
			     <td><%=e_mail%></td>
			     <td><%=location%></td>
			
			     <td>
			      <a href="/student/student_modify.jsp?idx=<%=idx%>"><button type="button" class="btn btn-primary btn-xs btn-lg">
          			<span class="glyphicon glyphicon-edit"></span>Modify</button></a>
           			<a href="/student/stu_db_delete.jsp?idx=<%=idx%>"><button type="button" class="btn btn-primary btn-xs btn-lg">
          			<span class="glyphicon glyphicon-trash"></span>Delete</button></a>
				</td>
			   </tr>
				<%
				  } //while
				} // if else
				%>
			  </tbody>
			</table>
			<div>
				<a href="/student/student_add.jsp?s_id=<%=s_id%>"><button type="button" class="btn btn-default">Add</button></a>
				<br>
			</div>

		</div> <!-- print_table -->
	</div> <!-- container -->
<%
	rs.close();
	stat.close();
	conn.close();
	}catch(Exception e) {
		throw new Exception(e);
	}
%>
<script type="text/javascript">

	$(document).ready(function() {
		var table = $("#student-table").dataTable({
			searching: true,
			info: false,
			paging: true,
			responsive: true,
		});
	})
	
</script>

</body>

</html>
