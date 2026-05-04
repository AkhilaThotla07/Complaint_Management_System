<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String employeeEmail = (String) session.getAttribute("email");
String name = (String) session.getAttribute("name");

if(employeeEmail == null){
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cancel Complaints</title>

<style>
body{
    margin:0;
    font-family: Arial, Helvetica, sans-serif;
    background:#f4f6fb;
}

/* Header */
.header{
    background:#6c63ff;
    color:white;
    padding:15px 30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.header a{
    text-decoration:none;
}

.logout-btn{
    background:white;
    color:#6c63ff;
    padding:8px 15px;
    border:none;
    border-radius:6px;
    cursor:pointer;
    font-weight:bold;
}

/* Container */
.container{
    padding:30px 60px;
}

h2{
    text-align:center;
    margin-bottom:30px;
}


table{
    width:100%;
    border-collapse:collapse;
    background:white;
    box-shadow:0 0 15px rgba(0,0,0,0.1);
}

th{
    background:#6c63ff;
    color:white;
    padding:12px;
}

td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

tr:hover{
    background:#f1f1f1;
}


.cancel-btn{
    background:#ff6b6b;
    color:white;
    padding:6px 12px;
    border:none;
    border-radius:6px;
    cursor:pointer;
}

.cancel-btn:hover{
    background:#e25555;
}

.back-btn{
    margin-bottom:20px;
    padding:8px 15px;
    background:#6c63ff;
    color:white;
    border:none;
    border-radius:6px;
    cursor:pointer;
}
</style>
</head>

<body>

<div class="header">
    <h3>Welcome <%=name%></h3>
    <a href="logout.jsp"><button class="logout-btn">Logout</button></a>
</div>

<div class="container">

<a href="employeeHome.jsp">
    <button class="back-btn">⬅ Back to Dashboard</button>
</a>

<h2>Pending Complaints Assigned To You</h2>

<table>
<tr>
    <th>Complaint</th>
    <th>Email</th>
    <th>Status</th>
    <th>Raised At</th>
    <th>Action</th>
</tr>

<%
boolean hasData=false;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn=DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/complaintsystem","root","root");

    PreparedStatement stmt = conn.prepareStatement(
    "SELECT * FROM complaints WHERE user_email=? AND status='Pending'");
    stmt.setString(1, employeeEmail);

    ResultSet rs = stmt.executeQuery();

    while(rs.next()){
        hasData=true;
        Timestamp ts = rs.getTimestamp("raised_at");
        String time = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm").format(ts);
%>

<tr>
    <td><%= rs.getString("complaint_text") %></td>
    <td><%= rs.getString("user_email") %></td>
    <td><%= rs.getString("status") %></td>
    <td><%= time %></td>
    <td>
        <a href="cancelComplaint.jsp?cid=<%= rs.getInt("complaint_id") %>">
            <button class="cancel-btn">Cancel</button>
        </a>
    </td>
</tr>

<%
    }

    if(!hasData){
%>
<tr>
    <td colspan="5">No Pending Complaints Found 🙂</td>
</tr>
<%
    }
}catch(Exception e){
    out.println(e);
}
%>

</table>
</div>
</body>
</html>