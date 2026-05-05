<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String name=(String)session.getAttribute("name");
String email=(String)session.getAttribute("email");
String role=(String)session.getAttribute("role");


if(name==null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<style>
body{
    margin:0;
    font-family: Arial, Helvetica, sans-serif;
    background:#f4f6fb;
}

/* Header */
.header{
    background:#ff6b6b;
    color:white;
    padding:15px 30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.logout-btn{
    background:white;
    color:#ff6b6b;
    padding:8px 15px;
    border:none;
    border-radius:6px;
    cursor:pointer;
    font-weight:bold;
}

.logout-btn:hover{
    background:#eee;
}

/* Dashboard */
.container{
    text-align:center;
    margin-top:40px;
}

.welcome{
    font-size:24px;
    margin-bottom:10px;
}

.info{
    color:gray;
    margin-bottom:30px;
}

/* Cards */
.cards{
    display:flex;
    justify-content:center;
    gap:30px;
    flex-wrap:wrap;
}

.card{
    background:white;
    padding:30px;
    width:260px;
    border-radius:12px;
    box-shadow:0 0 15px rgba(0,0,0,0.1);
    transition:0.3s;
}

.card:hover{
    transform:translateY(-5px);
}

.card button{
    margin-top:15px;
    padding:10px 15px;
    width:100%;
    background:#ff6b6b;
    color:white;
    border:none;
    border-radius:6px;
    cursor:pointer;
}

.card button:hover{
    background:#e25555;
}
</style>
</head>

<body>

<!-- Header -->
<div class="header">
    <h2>Admin Dashboard</h2>
    <a href="logout.jsp"><button class="logout-btn">Logout</button></a>
</div>

<div class="container">
    <div class="welcome">Welcome Admin, <%=name%> 👋</div>
    <div class="info">Email: <%=email%></div>

    <div class="cards">

        <div class="card">
            <h3>All Complaints</h3>
            <p>View every complaint in system.</p>
            <a href="viewAllComplaints.jsp">
                <button>Open</button>
            </a>
        </div>

        <div class="card">
            <h3>Resolved Complaints</h3>
            <p>Check resolved complaints.</p>
            <a href="viewResolvedComplaints.jsp">
                <button>Open</button>
            </a>
        </div>

        <div class="card">
            <h3>Pending Complaints</h3>
            <p>Check pending complaints.</p>
            <a href="showPendingComplaints.jsp">
                <button>Open</button>
            </a>
        </div>

    </div>
</div>

</body>
</html>