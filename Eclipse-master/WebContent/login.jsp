<%@page contentType="text/html; charset=utf-8" errorPage="/Error.jsp" %>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login</title>
  <link rel="stylesheet" href="css/style.css" title="style1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" title="style1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <style>
	body{		/*배경 사진 */
		background-image:url('/img/1.jpg');
    	background-size: 100% 130%;
	}
  </style>
</head>

<body>
<%
	/* 브라우저 호환 확인 */
	String browser = "";
	String userAgent = request.getHeader("User-Agent");
	if (userAgent.indexOf("Trident") > 0 || userAgent.indexOf("MSIE") > 0) {
	 browser = "IE";
	} else if (userAgent.indexOf("Opera") > 0) {
	 browser = "Opera";
	} else if (userAgent.indexOf("Firefox") > 0) {
	 browser = "Firefox";
	} else if (userAgent.indexOf("Safari") > 0) {
	 if (userAgent.indexOf("Chrome") > 0) {
	  browser = "Chrome";
	 } else {
	  browser = "Safari";
	 }
	}
	if(!browser.equals("IE")) {
		Cookie[] cookies = request.getCookies();
		
		boolean foundCookie = false;
		String userId = "";
		
		for(int i = 0; i < cookies.length; i++) {
			Cookie c = cookies[i];
			if (c.getName().equals("userid")){
				userId = c.getValue();
				foundCookie = true;
			}
		}
%>

	<div class="row">			<!-- [[[login 화면 맨 윗줄]]] -->	
		<div class="col-sm-8 main-title-login" style=" padding-left: 10%;">Logo</div>				
 		
	</div>
	<!-- info-modal -->
	<div id="info-modal" class="modal fade"  role="dialog" style="text-align:center;">
	  <div class="modal-dialog">			
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">Information</h4>
	      </div>
	      <div class="modal-body">
	        <p>Some text in the Information.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	
	  </div>
	</div>
	
	<!-- contact-modal -->
	<div id="contact-modal" class="modal fade"  role="dialog" style="text-align:center;">
	  <div class="modal-dialog">			
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">Contact</h4>
	      </div>
	      <div class="modal-body">
	        <p>Some text in the Contact.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>			
	  </div>
	</div>
	
	<!--[[[login 입력 칸]]] -->
	<div class="col-md-500">	
		<div>
	 		<div class="modal-dialog" style="opacity:.93;">
			    <div class="col-md-15 panel panel-group panel-default">		
			      <div class="panel-heading">
			        <h2>Sign In</h2> 
			      </div>		  
			      <div class="panel-body">
			        <form role="form" method="post" action="/login_check.jsp">
			          <fieldset>			  
			            <div class="form-group">
			            <% if(foundCookie) { %>
			              <input class="form-control" name="id" value="<% out.print(userId); %>">
			            <% } else { %>
			              <input class="form-control" placeholder="Enter your ID" name="id">
			            <% } %>
			            </div>				
			            <div class="form-group">
			              <input class="form-control" placeholder="Enter your password" name="pwd" type="password">
			            </div>				
			            <div class="checkbox">
			              <label>
			                <input name="remember" type="checkbox">Remember Me
			              </label>
			            </div>				
			              <input type="submit" class="btn btn-sm btn-success" value="submit">
			          </fieldset>
			        </form>
			      </div>		  
			    </div>
			    <div>
			    	<div class="main-btn-login" style="float:left;" >
		 				<a data-toggle="modal" data-target="#info-modal" style="color:white; cursor: hand;">Information</a>
			  		</div>		
			 		<div class="main-btn-login"  style="float:right; text-align:right">
			 			<a data-toggle="modal" data-target="#contact-modal" style="color:white; cursor: hand;">Contact</a>
				  	</div>
			    </div>
			    
			  </div>
			  
		</div>		
	</div>
<% }else { %>
	
	<div class="col-md-500">	
		<div>
	 		<div class="modal-dialog" style="opacity:.93;">
			    <div class="col-md-15 panel panel-group panel-default">		
			      <div class="panel-heading">
			        <span style="text-align:center;font-size:3vmin;">Microsoft Explorer not supported.</span> 
			      </div>		  
			      <div class="panel-body">
			        <span style="text-align:center;font-size:3vmin;">Please use other browser than IE.</span>
			      </div>		  
			    </div> 
			 </div>
			  
		</div>		
	</div>
<%
	} 
%>

</body>
</html>