<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp" %>
<%@page import="java.sql.*"%>

<%
  request.setCharacterEncoding("utf-8");
  response.setContentType("utf-8");
  String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
  String db_user="admin";
  String db_pwd="dbadministrator";

  int total=0;  // 총 자산의 개수 구할 때, 사용 할 변수
  int a_id=0;

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

String query = "select count(*) from asset";
ResultSet rs = stat.executeQuery(query);
  if(rs.next())
  {
    total = rs.getInt(1); // 자산 수를 저장.
  }
  rs.close(); // 자산 수 세는 쿼리 끝나고 닫음.

  query = "select max(a_no) from asset";
  rs = stat.executeQuery(query);

  if(rs.next())
  {
    a_id = rs.getInt(1);
  }
  rs.close();

  query = "SELECT asset.*, member.name as m_name FROM asset INNER JOIN member ON asset.m_no = member.m_no"; // 학생 정보 얻어오기위한 쿼리 저장
  rs = stat.executeQuery(query);


%>
<!--	DB 세팅 완료		-->

<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>

<div class="container container-margin">

  <div>
    <h2>Asset Information</h2>
    <br>
<%
  out.print("Total : "+total);
%>
<br>
<a href = /asset/asset_excel.jsp>Save as MS-Excel</a>
<br>
<br>
    <table class="table table-striped" id="entries-table">
          <thead>
            <tr>
              <th data-priority="1">NO.</th>
              <th data-priority="1">S/N</th>
              <th>Name</th>
              <th>Location</th>
              <th>Manager</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
<%
  if(total==0){
%>
            <tr>
              <td colspan="7">No asset information.</td>
            </tr>
<%
  }else{
    while(rs.next()){	   	
      int idx = rs.getInt("a_no");
      String s_n = rs.getString("sn");
      String name = rs.getString("name");
      String location = rs.getString("location");
      String m_no = rs.getString("m_no");
      String m_name = rs.getString("m_name");
%>

            <tr>
              <td ><%=idx%></td>
              <td ><%=s_n%></td>
              <td><%=name%></td>
              <td><%=location%></td>
              <td><%=m_name%></td>
     
              <td>
              <a href="/asset/asset_modify.jsp?idx=<%=idx%>"><button type="button" class="btn btn-primary btn-xs btn-lg">
          	<span class="glyphicon glyphicon-edit"></span>Modify</button></a>
           	<a href="/asset/asset_db_delete.jsp?idx=<%=idx%>"><button type="button" class="btn btn-primary btn-xs btn-lg">
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
          <a href="/asset/asset_add.jsp?a_id=<%=a_id%>"><button type="button" class="btn btn-default">Add</button></a>
          <br>
        </div>

        </div>
        
      </div>


<%
rs.close();
stat.close();
conn.close();
}catch(Exception e)
{
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
