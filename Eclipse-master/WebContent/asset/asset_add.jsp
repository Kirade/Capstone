
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.sql.*"%>

<%
  response.setContentType("utf-8");
	request.setCharacterEncoding("utf-8");
	int idx = Integer.parseInt(request.getParameter("a_id"));
%>
<!--
    DB 세팅 완료
  -->

<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>


  <div class="container container-margin">

    <h2>Add Asset Information</h2>
    <p>
    <form method="post" action="/asset/asset_db_add.jsp">
      <table class="table table-bordered small">
        <tr>
          <th class="success">SN</th>
          <td>
            <input type="text" name="sn" value="" required>
          </td>
        </tr>
        <tr>
          <th class="success">Name</th>
          <td>
            <input type="text" name="name" value="" required>
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
              <option>Location 5</option>
            </select>
          </td>
        </tr>
        <tr>
          <th class="success">Manager</th>
          <td>
            <input type="text" name="manager" value="" required>
          </td>
        </tr>
      </table>
    </p>
      <input type="submit" class="btn btn-default" value="Save">
      <input type="reset" class="btn btn-default" value="Reset">
      <a href="/asset/asset_administration.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>
    </form>
  </div>
</body>
</html>
