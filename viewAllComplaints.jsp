<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String role=(String) session.getAttribute("role");
if(role==null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Complaints</title>

<style>
body{
    font-family:Arial;
    background:linear-gradient(to right,#2193b0,#6dd5ed);
    padding:40px;
}

.container{
    background:white;
    padding:30px;
    border-radius:12px;
    width:95%;
    margin:auto;
    box-shadow:0 0 20px rgba(0,0,0,0.25);
}

h2{
    text-align:center;
    color:#2c3e50;
}

table{
    width:100%;
    margin-top:20px;
    border-collapse:separate;   
    border-spacing:0;          
    border-radius:12px;
    overflow:hidden;           
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

.actionBtn{
    border:none;
    padding:6px 12px;
    border-radius:5px;
    color:white;
    cursor:pointer;
}
.resolve{ 
background:#27ae60; 
}
.reject{ 
background:#e74c3c;
 }

.backBtn{
    margin-top:25px;
    padding:12px 25px;
    background:#2c3e50;
    color:white;
    border:none;
    border-radius:8px;
    cursor:pointer;
}
.backBtn:hover{ background:#1a252f; }

</style>
</head>

<body>
<div class="container">
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
PreparedStatement stmt=conn.prepareStatement("SELECT * FROM complaints ORDER BY complaint_id DESC");
ResultSet rs=stmt.executeQuery();

while(rs.next()){
    int cid = rs.getInt("complaint_id");
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
        resolvedTime="Cancelled by User";
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
        admin_remark="Not yet solved by you";
    } else if(status.equalsIgnoreCase("Resolved")){
        badgeClass="resolved"; 
        rowClass="row-resolved";
        admin_remark=resolution;
    } else if(status.equalsIgnoreCase("Rejected")){
        badgeClass="rejected"; 
        rowClass="row-rejected";
        admin_remark="Rejected by you";
    } else {
        badgeClass="cancelled"; 
        rowClass="row-cancelled";
        admin_remark="Cancelled by user";
    }
%>

<tr class="<%=rowClass%>">
    <td><%=user_name%></td>
    <td><%=user_email%></td>
    <td><%=complaint_text%></td>
    <td><%=raisedTime%></td>
    <td><span class="badge <%=badgeClass%>"><%=status%></span></td>
    <td><%=admin_remark %></td>
    <td><%=resolvedTime%></td>

    <td>
    <% if(status.equalsIgnoreCase("Pending")){ %>
        <a href="resolveComplaints.jsp?cid=<%=cid%>&action=resolve">
            <button class="actionBtn resolve">Resolve</button>
        </a>
        <a href="updateStatus.jsp?cid=<%=cid%>&action=reject">
            <button class="actionBtn reject">Reject</button>
        </a>
    <% } else { %>
        Completed
    <% } %>
    </td>
</tr>

<%
}
conn.close();
%>

</table>

<div>
<a href="adminHome.jsp">
    <button class="backBtn">⬅ Back to Dashboard</button>
</a>
</div>

</div>
</body>
</html>