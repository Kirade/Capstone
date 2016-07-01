
<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp" %>
<%@page import="java.sql.*"%>

<%
  request.setCharacterEncoding("utf-8");
  response.setContentType("utf-8");
  String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
  String db_user="admin";
  String db_pwd="dbadministrator";

  int total=0;  // 총 local manager 수 구할 때, 사용 할 변수
  int l_id=0; // 마지막 index 저장

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
	
	String query = "select count(*) from member WHERE level='Local_Manager'";
	ResultSet rs = stat.executeQuery(query);
	  if(rs.next())
	  {
	    total = rs.getInt(1); // 지역관리자 수를 저장.
	  }
	  rs.close(); // 지역 관리자  수 세는 쿼리 끝나고 닫음.

	  query = "select max(m_no) from member";
	  rs = stat.executeQuery(query);

	  if(rs.next())
	  {
	    l_id = rs.getInt(1); // 마지막 학번을 저장.
	  }
	  rs.close();
	  
	  query = "select m_no as l_id ,name,gender,address,e_mail from member WHERE level='Local_Manager'"; // 지역관리자 정보 얻어오기위한 쿼리 저장
	  rs = stat.executeQuery(query);
%>
<!-- DB 세팅 완료 -->
  
<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>


<div class="container container-margin">
  <div>
  
    <h2>Local Manager Information</h2>
    <br>
<%
	out.print("Total : " + total);
%>
	<br>
	<br>
	<br>
	
    
    <table class="table table-striped" id="entries-table">
    	<thead>
    		<tr>
    			<th data-priority="1">ID</th>
    			<th data-pritority="1">Name</th>
    			<th>Gender</th>
    			<th>Address</th>
    			<th>E-mail</th>
    			<!-- <th>Location</th>-->
    			<th>Modify</th>
    		</tr>
    	</thead>
    	<tbody>
<%
	if(total == 0){
%>
		<tr>
			<td colspan="7"> No local manager information.</td>
		</tr>
<%
	}else{
		while(rs.next()){
			int idx = rs.getInt("l_id");
			String name = rs.getString("name");
			String gender = rs.getString("gender");
			String address = rs.getString("address");
			String e_mail = rs.getString("e_mail");
			//String location = rs.getString("location");
			
%>
		<tr>
			<td><%=idx %></td>
			<td><%=name %></td>
			<td><%=gender%></td>
			<td><%=address %></td>
			<td><%=e_mail %></td>
			
			
			<td><a href="/localmanager/local_manager_modify.jsp?idx=<%=idx%>"><button type="button" class="btn btn-primary btn-xs btn-lg">
          			<span class="glyphicon glyphicon-edit"></span>Modify</button></a>
           			<a href="/localmanager/local_manager_db_delete.jsp?idx=<%=idx%>"><button type="button" class="btn btn-primary btn-xs btn-lg">
          			<span class="glyphicon glyphicon-trash"></span>Delete</button></a>
          		</td>
		</tr>
<%
	}
}
%>
    	</tbody>
    </table>
    <div>
    	<a href="/localmanager/local_manager_add.jsp?l_id=<%=l_id%>"><button type="button" class="btn btn-default">Add</button></a>
    	<br>
    </div>
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
			responsive: true,
		});
	})
	
</script>
</body>
</html>
