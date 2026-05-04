<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String role=(String) session.getAttribute("role");
if(role==null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
}

String cid=request.getParameter("cid");
String action=request.getParameter("action");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resolve Complaint</title>

<style>
body{
    font-family:Arial;
    background:linear-gradient(to right,#11998e,#38ef7d);
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.container{
    background:white;
    padding:30px;
    border-radius:12px;
    width:420px;
    box-shadow:0 0 15px rgba(0,0,0,0.25);
}

h2{
text-align:center;
color:#2c3e50;
}

textarea{
    width:100%;
    height:120px;
    padding:10px;
    border-radius:8px;
    border:1px solid #ccc;
}

button{
    width:100%;
    padding:12px;
    margin-top:15px;
    background:#27ae60;
    color:white;
    border:none;
    border-radius:8px;
    font-size:16px;
    cursor:pointer;
}
button:hover{
background:#219150;
}
</style>
</head>

<body>

<div class="container">

<% if(action.equals("resolve")){	
%>

    <h2>🛠 Resolve Complaint</h2>

    <form action="saveResolution.jsp" method="post">
        <input type="hidden" name="cid" value="<%=cid%>">

        <label>Write Resolution Note:</label><br><br>
        <textarea name="resolution" required></textarea>

        <button>Submit Resolution</button>
    </form>

<% } else { %>

    <h2>Invalid Request</h2>

<% } %>

</div>
</body>
</html>