<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String email = (String) session.getAttribute("email");
String role  = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Complaint Management System</title>

<style>
*{
    margin:0;
    padding:0;
    font-family:'Segoe UI',sans-serif;
}

/* NAVBAR */
nav{
    background:#2c3e50;
    color:white;
    padding:15px 60px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

nav h2{ letter-spacing:1px; }

nav a{
    color:white;
    text-decoration:none;
    margin-left:25px;
    font-weight:bold;
    transition:0.3s;
}
nav a:hover{ color:#f1c40f; }

/* HERO */
.hero{
    height:90vh;
    background:url("https://images.unsplash.com/photo-1521791136064-7986c2920216") no-repeat center/cover;
    display:flex;
    align-items:center;
    justify-content:center;
    text-align:center;
    color:white;
}

.hero-box{
    background:rgba(0,0,0,0.65);
    padding:45px 70px;
    border-radius:12px;
}

.hero h1{ font-size:48px; margin-bottom:15px; }
.hero p{ font-size:20px; margin-bottom:25px; }

.btn{
    padding:12px 28px;
    border:none;
    border-radius:6px;
    font-size:16px;
    cursor:pointer;
    margin:10px;
}
.login{ background:#27ae60; color:white; }
.register{ background:#e67e22; color:white; }
.dashboard{ background:#3498db; color:white; }

.btn:hover{ transform:scale(1.05); }

/* FEATURES */
.features{
    padding:70px;
    text-align:center;
    background:#f4f6f7;
}

.cards{
    display:flex;
    justify-content:space-around;
    margin-top:40px;
}

.card{
    background:white;
    padding:25px;
    width:28%;
    border-radius:12px;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
    transition:0.3s;
}
.card:hover{ transform:translateY(-10px); }

.card img{
    width:80px;
    margin-bottom:15px;
}

/* FOOTER */
footer{
    background:#2c3e50;
    color:white;
    text-align:center;
    padding:18px;
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav>
    <h2>ComplaintCare</h2>
    <div>

        <a href="index.jsp">Home</a>

        <% if(email == null){ %>
            <a href="login.jsp">Login</a>
            <a href="signup.jsp">Register</a>
        <% } else { %>
            <% if(role.equals("admin")){ %>
                <a href="adminHome.jsp">Dashboard</a>
            <% } else { %>
                <a href="employeeHome.jsp">Dashboard</a>
            <% } %>
            <a href="logout.jsp">Logout</a>
        <% } %>

    </div>
</nav>

<!-- HERO SECTION -->
<section class="hero">
    <div class="hero-box">
        <h1>Smart Complaint Management</h1>
        <p>Raise • Track • Resolve Complaints Easily</p>

        <% if(email == null){ %>
            <a href="login.jsp"><button class="btn login">Login</button></a>
            <a href="signup.jsp"><button class="btn register">Register</button></a>
        <% } else { %>
            <% if(role.equals("admin")){ %>
                <a href="adminHome.jsp"><button class="btn dashboard">Go to Admin Dashboard</button></a>
            <% } else { %>
                <a href="employeeHome.jsp"><button class="btn dashboard">Go to Employee Dashboard</button></a>
            <% } %>
        <% } %>

    </div>
</section>

<!-- FEATURES -->
<section class="features">
    <h2>Why Use Our System?</h2>

    <div class="cards">

        <div class="card">
            <img src="https://cdn-icons-png.flaticon.com/512/1828/1828843.png">
            <h3>Easy Complaint Raise</h3>
            <p>Employees can quickly submit complaints in seconds.</p>
        </div>

        <div class="card">
            <img src="https://cdn-icons-png.flaticon.com/512/190/190411.png">
            <h3>Track Status</h3>
            <p>Monitor complaint progress in real-time.</p>
        </div>

        <div class="card">
            <img src="https://cdn-icons-png.flaticon.com/512/190/190406.png">
            <h3>Quick Resolution</h3>
            <p>Admins resolve issues fast with transparency.</p>
        </div>

    </div>
</section>

<!-- FOOTER -->
<footer>
    © 2026 Complaint Management System | Made with ❤
</footer>

</body>
</html>