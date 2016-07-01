
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
  conn=DriverManager.getConnection(db_url,db_user,db_pwd);
  if(conn==null)
  {
  throw new Exception("DB 연결 Error");
}
stat = conn.createStatement();

String query = "select * from asset where a_no="+idx;
ResultSet rs = stat.executeQuery(query);

if(rs.next())
{
  String sn = rs.getString("sn");
  String name = rs.getString("name");
  String location = rs.getString("location");
  int m_no = rs.getInt("m_no");
%>
<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>


<div class="container container-margin">
  <h2>Modify Asset Information</h2>
  <p>
  <form method="post" action="/asset/asset_db_modify.jsp?idx=<%=idx%>">
  <table class="table table-bordered small">
    <tr>
      <th class="success">No.</th>
      <td><%=idx%></td>
    </tr>
    <tr>
      <th class="success">S/N</th>
      <td>
        <input type="text" name="sn" value="<%=sn%>">
      </td>
    </tr>
    <tr>
      <th class="success">Name</th>
      <td>
        <input type="text" name="name" value="<%=name%>">
      </td>
    </tr>
    <tr>
      <th class="success">Location</th>
      <td>
      	<select name="location" size="5">
      		<option <%if(location.equals("Location 1")){out.print("selected");}%>>Location 1</option>
            <option <%if(location.equals("Location 2")){out.print("selected");}%>="location 2">Location 2</option>
            <option <%if(location.equals("Location 3")){out.print("selected");}%>="location 3">Location 3</option>
            <option <%if(location.equals("Location 4")){out.print("selected");}%>="location 4">Location 4</option>
      	</select>
      </td>
    </tr>
    <tr>
      <th class="success">Manager</th>
      <td>
        <input type="text" name="m_no" value="<%=m_no%>">
      </td>
    </tr>
  </table>
  </p>
  <input type="submit" class="btn btn-default" value="Save">
  <input type="reset" class="btn btn-default" value="Reset">
  <a href="/asset/asset_administration.jsp"><button type="button" class="btn btn-default">Back</button></a>
</form>
</div>
</body>
<%
}
}catch(Exception e)
{
  throw new Exception(e);
}
%>
</html>