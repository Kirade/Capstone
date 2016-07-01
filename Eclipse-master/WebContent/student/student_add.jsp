<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.sql.*"%>

<%
  response.setContentType("utf-8");
	request.setCharacterEncoding("utf-8");
	int s_id = Integer.parseInt(request.getParameter("s_id"));

%>
<!--
    DB 세팅 완료
  -->

<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>

  <div class="container container-margin">

    <h2>Add Student Information</h2>
    <p>
    <form method="post" action="/student/stu_db_add.jsp">
      <table class="table table-bordered small">
        <tr>
          <th class="success">No.</th>
          <td><%=s_id+1%></td>
        </tr>
        <tr>
          <th class="success">Name</th>
          <td>
            <input type="text" name="name" value="" required>
          </td>
        </tr>
        <tr>
          <th class="success">Gender</th>
          <td>
						<input type="radio" name="gender" value="M" checked>M
            <input type="radio" name="gender" value="F">F
          </td>
        </tr>
        <tr>
          <th class="success">Address</th>
          <td>
            <input type="text" name="address" value="">
          </td>
        </tr>
        <tr>
          <th class="success">E-mail</th>
          <td>
            <input type="text" name="e_mail" value="">
          </td>
        </tr>
        <tr>
          <th class="success">Location</th>
          <td>
            <select name="location" size = "5" required>
              <option>Location 1</option>
              <option>Location 2</option>
              <option>Location 3</option>
              <option>Location 4</option>
            </select>
          </td>
        </tr>
      </table>
    </p>
      <input type="submit" class="btn btn-default" value="Save">
      <input type="reset" class="btn btn-default" value="Reset">
      <a href="/student/student_administration.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>
    </form>
  </div>
</body>
</html>
