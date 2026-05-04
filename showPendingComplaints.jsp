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
<title>Show Pending Complaints</title>
</head>
<body>

<h2>📊 All Employee Complaints</h2>

<table>
<tr>
    <th>Employee Name</th>
    <th>Email</th>
    <th>Complaint</th>
    <th>Raised At</th>
    <th>Status</th>
    <th>Resolution</th>
    <th>Resolved At</th>
    <th>Action</th>
</tr>
<% 


Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/complaintsystem?user=root&&password=root";
Connection conn=DriverManager.getConnection(url);
PreparedStatement stmt=conn.prepareStatement("SELECT * FROM complaints WHERE status='pending'");
ResultSet rs=stmt.executeQuery();

while(rs.next()){
    int cid = rs.getInt("complaint_id");
    String user_name=rs.getString("user_name");
    String user_email=rs.getString("user_email");
    String complaint_text=rs.getString("complaint_text");
    String status=rs.getString("status");
   
    
    


%>
<%} %>







</table>

</body>
</html>