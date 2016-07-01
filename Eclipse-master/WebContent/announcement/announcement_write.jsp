
<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp" %>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
response.setContentType("utf-8");
request.setCharacterEncoding("utf-8");

int last_idx =Integer.parseInt(request.getParameter("last_idx"));

SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
Date d = new Date();
String date = format.format(d);
%>
<html lang="en">
<jsp:include page="/otherInclude.jsp"></jsp:include>

<body>

<div class="container container-margin">
  <h2>New Announcement</h2><br>
  <form method="post" action="/announcement/announcement_db_add.jsp">
    No.<%=last_idx+1%>
    <input type="hidden" name="idx" value="<%=last_idx+1%>"><br><br>
    <p>
    <b>Writer</b> : ${name}
    <input type="hidden" name="writer" value="${name}">

  <div class="form-group">
    <b>Date</b> : <%=date%>
    <input type="hidden" name="date" value="<%=date%>"><br></p>
      <label for="title">Title: </label>
      <input type="text" class="form-control" name="title" >
    </div><br>
    <div class="form-group">
      <label for="content">Content: </label>
      <textarea class="form-control" rows="10" name="content" id="content"></textarea>
    </div>
    <input type="submit" class="btn btn-default" value="Save">
    <input type="reset" class="btn btn-default" value="Reset">
    <a href="/announcement/announcement.jsp"><button type="button" class="btn btn-default">Back</button></a>
  </form>
</div>
</body>
</html>
