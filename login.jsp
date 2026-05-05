<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Login</title>

<style>
body{
    font-family: Arial, Helvetica, sans-serif;

   
    background: 
        linear-gradient(rgba(0,0,0,0.45), rgba(0,0,0,0.45)),
        url("https://images.unsplash.com/photo-1551434678-e076c223a692");

    background-size: cover;
    background-position: center;
    background-attachment: fixed;

    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    margin:0;
}


.container{
    background: rgba(255,255,255,0.95);
    backdrop-filter: blur(6px);
    padding:35px 40px;
    border-radius:14px;
    box-shadow:0 10px 30px rgba(0,0,0,0.25);
    width:360px;
}

h2{
    text-align:center;
    margin-bottom:25px;
    color:#333;
}

input{
    width:100%;
    padding:11px;
    margin:10px 0 18px 0;
    border:1px solid #ccc;
    border-radius:6px;
    transition:0.3s;
}

input:focus{
    border-color:#6c63ff;
    outline:none;
    box-shadow:0 0 6px #6c63ff;
}

button{
    width:100%;
    padding:11px;
    background:#6c63ff;
    border:none;
    color:white;
    font-size:16px;
    border-radius:6px;
    cursor:pointer;
    transition:0.3s;
}

button:hover{
    background:#574fd6;
}

.msg{
    text-align:center;
    font-weight:bold;
    margin-top:15px;
    color:#e74c3c;
}

.signup-text{
    text-align:center;
    margin-top:18px;
    font-size:14px;
}

.signup-text a{
    color:#6c63ff;
    text-decoration:none;
    font-weight:bold;
}

.signup-text a:hover{
    text-decoration:underline;
}
</style>
</head>

<body>

<div class="container">
<h2>Welcome Back 👋</h2>

<form action="login.jsp" method="post">
   
    <input type="email" name="email"  placeholder ="Email"required>

   
    <input type="password" name="password" placeholder="Password" required>

    <button>Login</button>
</form>

<p class="signup-text">
Don't have an account? 
<a href="signup.jsp">Register</a>
</p>

<div class="msg">
<%
String email=request.getParameter("email");
String password=request.getParameter("password");

if(email!=null && password!=null){

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/complaintsystem?user=root&&password=root";
        
        Connection conn=DriverManager.getConnection(url);
        PreparedStatement stmt=conn.prepareStatement("SELECT * FROM users WHERE email=?");
        stmt.setString(1,email);
        ResultSet rs=stmt.executeQuery();
        
        if(rs.next()){
            String db_pwd=rs.getString("password");
            String role=rs.getString("role");
            String name=rs.getString("name");
            
            if(password.equals(db_pwd)){
                session.setAttribute("name", name);
                session.setAttribute("role", role);
                session.setAttribute("email", email);

                if(role.equals("admin"))
                    response.sendRedirect("adminHome.jsp");
                else
                    response.sendRedirect("employeeHome.jsp");
            }
            else{
                out.println("Wrong Password ❌");
            }
        } 
        else{
            out.println("User not found ❌");
        }
        
    }catch(Exception e){
        out.println("Error : "+e);
    }
}
%>
</div>

</div>
</body>
</html>