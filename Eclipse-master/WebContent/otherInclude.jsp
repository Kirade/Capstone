<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp" %>
<%@page import="java.sql.*"%>

<%	String memberId = (String)session.getAttribute("id");
boolean login = memberId == null ? false : true;
if(!login) {
  response.sendRedirect("login.jsp");
}
 %>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Student Administration</title>
    <link rel="stylesheet" href="/css/style.css" title="style1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" title="style1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
 
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/u/bs/dt-1.10.12,r-2.1.0/datatables.min.css"/>
	<script type="text/javascript" src="https://cdn.datatables.net/u/bs/dt-1.10.12,r-2.1.0/datatables.min.js"></script>
  
</head>

<body>

<div class="row">			<!--[[[login 화면 맨 윗줄]]] -->
	<div class="col-xs-6 main-title" style="padding-left: 10%;">Logo</div>
	<div class="col-xs-2 main-btn btn-md" style="padding-right:3%; text-align:right;">
		<a href="/nav.jsp" style=" color:#585858;">Home</a>
	</div>
	<div class="col-xs-1 main-btn btn-md" style="text-align:center;">
		<a href="/img/SiteMap.jpg" target="_blank" style=" color:#585858;">Site map</a>
	</div> 
	<div class="col-xs-2 main-btn btn-md" style="padding-left:3%;">
		<a href="/logout.jsp" style=" color:#585858;">Sign Out</a>
	</div> 
</div>

<nav class="navbar navbar-default">		<!-- 네비게이션 바 -->
  <div class="container-fluid">  
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu-navbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>
	
      <div class="collapse navbar-collapse" id="menu-navbar">
        <ul class="nav navbar-nav navcenter" style="padding-left:6%">
         	<li><a href="/student/student_administration.jsp">Student Administration</a></li>
          	<li><a href="/asset/asset_administration.jsp">Asset Administration</a></li>
          	<li><a href="/announcement/announcement.jsp?p=1">Announcement</a><li>
          	<li><a href="/reference/references.jsp?p=1">References</a></li>
          	<li><a href="/schedules.jsp">Schedules</a></li>
               
<%		/*  권한에 따른 메뉴 분리 */
  String levelCheck = (String)session.getAttribute("level");
	if(levelCheck.equals("Administrator")){
%>

			<li><a href="/localmanager/local_manager.jsp">Local Managers</a></li>
<% } %>

		</ul>
      </div>
  	</div>
</nav>

 <!-- 사진-->
<div>
	<img src="/img/3.jpg" style="width:100%; height:12%; position: relative; top: -20px;">
</div>



</body>

</html>
