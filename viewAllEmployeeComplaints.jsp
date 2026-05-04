<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String email=(String) session.getAttribute("email");

if(email==null){
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Complaints</title>

<style>
body{
    font-family:Arial;
    background:linear-gradient(to right,#74ebd5,#acb6e5);
    padding:40px;
}


.container{
    background:white;
    padding:30px;
    border-radius:10px;
    width:90%;
    margin:auto;
    box-shadow:0 0 15px rgba(0,0,0,0.2);
}

h2{
    text-align:center;
    color:#2c3e50;
}


table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}

th{
    background:#2c3e50;
    color:white;
    padding:12px;
}

td{
    padding:12px;
    text-align:center;
}


.row-pending{ 
background:#fff3cd;
 }
.row-resolved{ 
background:#d4edda; 
}
.row-rejected{ 
background:#f8d7da; 
}
.row-cancelled{ 
background:#e2e3e5;
 }


.badge{
    padding:6px 12px;
    border-radius:20px;
    color:white;
    font-size:12px;
    font-weight:bold;
}
.pending{
background:#f39c12;
}
.resolved{
background:#27ae60;
}
.rejected{
background:#e74c3c;
}
.cancelled{
background:#7f8c8d;
}

.backBtn{
    margin-top:20px;
    padding:10px 20px;
    background:#2c3e50;
    color:white;
    border:none;
    border-radius:6px;
    cursor:pointer;
}
.backBtn:hover{ background:#1a252f; }

</style>
</head>

<body>

<div class="container">
<h2>📋 Complaints Raised By You</h2>

<table>
<tr>
    <th>Name</th>
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
PreparedStatement stmt=conn.prepareStatement("SELECT * FROM complaints WHERE user_email=? ORDER BY complaint_id DESC");
stmt.setString(1,email);
ResultSet rs=stmt.executeQuery();

while(rs.next()){

    String user_name=rs.getString("user_name");
    String user_email=rs.getString("user_email");
    String complaint_text=rs.getString("complaint_text");
    String status=rs.getString("status");
    String resolution=rs.getString("admin_remark");

    Timestamp ts = rs.getTimestamp("raised_at");
    String raisedTime = new SimpleDateFormat("dd-MM-yyyy HH:mm").format(ts);

    Timestamp ts1 = rs.getTimestamp("resolved_at");
    String resolvedTime="";

    if(status.equals("Cancelled"))
        resolvedTime="Cancelled by You";
    else if(ts1!=null)
        resolvedTime=new SimpleDateFormat("dd-MM-yyyy HH:mm").format(ts1);
    else
        resolvedTime="Not Resolved Yet";

    
    String badgeClass="";
    String rowClass="";
    String admin_remark="";

    if(status.equalsIgnoreCase("Pending")){
        badgeClass="pending";
        rowClass="row-pending";
        admin_remark="Admin not responded";
    }
    else if(status.equalsIgnoreCase("Resolved")){
        badgeClass="resolved";
        rowClass="row-resolved";
        admin_remark=resolution;
        
    }
    else if(status.equalsIgnoreCase("Rejected")){
        badgeClass="rejected";
        rowClass="row-rejected";
        admin_remark="Admin Rejected the complaint";
    }
    else{
        badgeClass="cancelled";
        rowClass="row-cancelled";
        admin_remark="Complaint cancelled by you";

        
    }
%>

<tr class="<%=rowClass%>">
    <td><%=user_name%></td>
    <td><%=user_email%></td>
    <td><%=complaint_text%></td>
    <td><%=raisedTime%></td>
    <td><span class="badge <%=badgeClass%>"><%=status%></span></td>
    <td><%=admin_remark%></td>
    <td><%=resolvedTime%></td>
</tr>

<%
}

%>

</table>

<div>
<a href="employeeHome.jsp">
    <button class="backBtn">⬅ Back to Dashboard</button>
</a>
</div>

</div>
</body>
</html>