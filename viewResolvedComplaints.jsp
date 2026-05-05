<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resolved Complaints</title>

<style>
body{
    font-family: Arial, Helvetica, sans-serif;
    background:linear-gradient(to right,#2193b0,#6dd5ed);
    margin:0;
}

h2{
    text-align:center;
    padding:20px;
    color:#2c3e50;
}



.backBtn{
     background:#34495e;
    color:white;
    border:none;
    padding:10px 22px;
    border-radius:8px;
    font-size:15px;
    cursor:pointer;
    transition:0.3s;
}
.topBar{
    width:90%;
    margin:20px auto -10px auto;
    display:flex;
    justify-content:flex-start;
}

.backBtn:hover{
    background:#1c1c1c;
}


table{
    width:90%;
    margin:30px auto;
    border-collapse:collapse;
    background:white;
    box-shadow:0 0 15px rgba(0,0,0,0.15);
    border-radius:10px;
    overflow:hidden;
}

th{
    background:#34495e;
    color:white;
    padding:14px;
    font-size:16px;
}

td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #eee;
    font-size:15px;
}

tr:hover{
    background:#f5f7fa;
    
}


.resolved{
    background:#2ecc71;
    color:white;
    padding:6px 12px;
    border-radius:20px;
    font-size:13px;
    font-weight:bold;
}


.remark{
    font-style:italic;
    color:#555;
}
</style>

</head>
<body>

<h2>✅ Resolved Employee Complaints</h2>



<table>
<tr>
    <th>Employee Name</th>
    <th>Email</th>
    <th>Complaint</th>
    <th>Raised At</th>
    <th>Status</th>
    <th>Resolution</th>
    <th>Resolved At</th>
</tr>

<% 
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/complaintsystem?user=root&&password=root";
Connection conn=DriverManager.getConnection(url);
PreparedStatement stmt=conn.prepareStatement("SELECT * FROM complaints WHERE status='resolved'");
ResultSet rs=stmt.executeQuery();

while(rs.next()){
    String user_name=rs.getString("user_name");
    String user_email=rs.getString("user_email");
    String complaint_text=rs.getString("complaint_text");
    String status=rs.getString("status");
    String admin_remark=rs.getString("admin_remark");

    Timestamp ts = rs.getTimestamp("raised_at");
    String raisedTime = new SimpleDateFormat("dd-MM-yyyy HH:mm").format(ts);

    Timestamp rt = rs.getTimestamp("resolved_at");
    String resolvedTime = new SimpleDateFormat("dd-MM-yyyy HH:mm").format(rt);
%>

<tr>
    <td><%=user_name%></td>
    <td><%=user_email%></td>
    <td><%=complaint_text%></td>
    <td><%=raisedTime%></td>
    <td><span class="resolved"><%=status%></span></td>
    <td class="remark"><%=admin_remark%></td>
    <td><%=resolvedTime%></td>
</tr>

<% } %>

</table>
<div class="topBar">
    <a href="adminHome.jsp">
        <button class="backBtn">⬅ Back to Dashboard</button>
    </a>
</div>

</body>
</html>