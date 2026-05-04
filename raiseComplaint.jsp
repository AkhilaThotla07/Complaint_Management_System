<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String name=(String) session.getAttribute("name");
String email=(String) session.getAttribute("email");

if(name==null || email==null){
    response.sendRedirect("login.jsp");
}

String message="";
String method=request.getMethod();

if(method.equals("POST")){
    try{
        String complaint_text=request.getParameter("complaint");

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/complaintsystem","root","root");

        PreparedStatement stmt=conn.prepareStatement(
        "INSERT INTO complaints(user_name,user_email,complaint_text) VALUES(?,?,?)");

        stmt.setString(1,name);
        stmt.setString(2,email);
        stmt.setString(3,complaint_text);

        stmt.executeUpdate();

        message="Complaint Submitted Successfully ✅";
    }
    catch(Exception e){
        message="Error : "+e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Raise Complaint</title>

<style>
body{
    font-family: Arial;
    background: linear-gradient(to right,#00c6ff,#0072ff);
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.container{
    background:white;
    padding:35px;
    width:420px;
    border-radius:12px;
    box-shadow:0 0 15px rgba(0,0,0,0.2);
}

h2{
    text-align:center;
    margin-bottom:20px;
}

input, textarea{
    width:100%;
    padding:10px;
    margin-top:5px;
    border-radius:6px;
    border:1px solid #ccc;
}

textarea{
    height:120px;
    resize:none;
}

button{
    width:100%;
    padding:12px;
    background:#0072ff;
    color:white;
    border:none;
    border-radius:6px;
    margin-top:15px;
    font-size:16px;
    cursor:pointer;
}

button:hover{
    background:#005cd6;
}

.msg{
    text-align:center;
    color:green;
    font-weight:bold;
    margin-bottom:10px;
}
</style>
</head>

<body>

<div class="container">

<h2>Raise Complaint</h2>

<% if(!message.equals("")){ %>
    <div class="msg"><%=message %></div>
<% } %>

<form method="post">
    Name:
    <input type="text" value="<%=name%>" readonly>

    Email:
    <input type="email" value="<%=email%>" readonly>

    Write your Complaint:
    <textarea name="complaint" required></textarea>

    <button type="submit">Submit Complaint</button>
</form>

</div>

</body>
</html>