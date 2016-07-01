
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
<h2>New References</h2>
	<form action="/reference/reference_file.jsp" method="post" enctype="multipart/form-data" onsubmit="return formCheck();">
		No. <%=last_idx+1%>
    <input type="hidden" name="idx" value="<%=last_idx+1%>"><br><br>

    <p><b>Writer</b> : ${name}</p>
    <input type="hidden" name="writer" value="${name}">

    <div class="form-group">
      <b> Date </b> : <%=date%>
      <input type="hidden" name="date" value="<%=date%>"><br>
      <label for="type">Type: </label><br>
      <input type="radio" name="type" value="Document form">Document Form
      <input type="radio" name="type" value="Driver">Driver
    </div><br>
    <div class="form-group">
      <label for="title">Title: </label>
      <input type="text" class="form-control" name="title" id="title">
    </div><br>
    <div class="form-group">
      <label for="filename">Attachment: </label>
      	<input type="file" name="filename" id="filename">
      	
    </div>
    <br>
    <input type="submit" class="btn btn-primary" value="Save">
    <input type="reset" class="btn btn-primary" value="Reset">
    <a href="/reference/references.jsp"><button type="button" class="btn btn-primary">Back</button></a>
	</form>
	</div>
<script>
	function formCheck(){
		var title=document.forms[0].title.value;
		var type = document.forms[0].type.value;
		
		if(title==null || title==""){
			alert("Please enter the title.");
			document.forms[0].title.focus();
			return false;
		}
		if(type==null || type==""){
			alert("Please select the type");
			document.forms[0].content.focus();
			return false;
		}
	}
</script>
</body>
</html>
