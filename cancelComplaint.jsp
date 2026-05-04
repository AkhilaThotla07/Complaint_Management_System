<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String email = (String) session.getAttribute("email");

if(email == null){
    response.sendRedirect("login.jsp");
}

String message="";

String complaint_id = request.getParameter("cid");

if(complaint_id != null){
    try{
        int cid = Integer.parseInt(complaint_id);

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/complaintsystem","root","root");

        String query="UPDATE complaints SET status='Cancelled' WHERE complaint_id=? AND user_email=? AND status='Pending'";
        PreparedStatement stmt = conn.prepareStatement(query);

        stmt.setInt(1, cid);
        stmt.setString(2, email);

        int rows = stmt.executeUpdate();

        if(rows>0)
            message="Complaint Cancelled Successfully ✅";
        else
            message="Unable to Cancel Complaint ❌";
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
<title>Cancel Complaint</title>

<style>
body{
    font-family: Arial;
    background: linear-gradient(to right,#74ebd5,#9face6);
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.box{
    background:white;
    padding:40px;
    border-radius:12px;
    text-align:center;
    box-shadow:0 0 15px rgba(0,0,0,0.2);
}

.msg{
    font-size:20px;
    font-weight:bold;
    margin-bottom:20px;
}

button{
    padding:10px 20px;
    background:#6c63ff;
    color:white;
    border:none;
    border-radius:6px;
    
}
</style>



</head>
<body>

<div class="box">
    <div class="msg"><%=message%></div>
    <a href="employeeCancelComplaint.jsp"><button>Go Back</button></a>
</div>

</body>
</html>