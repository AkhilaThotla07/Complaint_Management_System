<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Registration</title>

<style>
body{
    font-family: Arial, Helvetica, sans-serif;

    /* background image */
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
    background: rgba(255,255,255,0.95);  /* semi transparent */
    padding:30px 40px;
    border-radius:12px;
    box-shadow:0 0 20px rgba(0,0,0,0.3);
    width:350px;
}

h2{
    text-align:center;
    margin-bottom:20px;
    color:#333;
}

.success{
    background:#d4edda;
    color:#155724;
    padding:12px;
    border-radius:6px;
    margin-bottom:15px;
    text-align:center;
    font-weight:bold;
}

.error{
    background:#f8d7da;
    color:#721c24;
    padding:12px;
    border-radius:6px;
    margin-bottom:15px;
    text-align:center;
    font-weight:bold;
}

input[type=text],
input[type=email],
input[type=password],
input[type=tel]{
    width:100%;
    padding:10px;
    margin:8px 0 15px 0;
    border:1px solid #ccc;
    border-radius:6px;
    box-sizing:border-box;
    transition:0.3s;
}

input:focus{
    border-color:#6c63ff;
    outline:none;
    box-shadow:0 0 5px #6c63ff;
}

.radio-group{
    margin-bottom:15px;
}

button{
    width:100%;
    padding:10px;
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

.login-text{
    text-align:center;
    margin-top:15px;
    font-size:14px;
}

.login-text a{
    color:#6c63ff;
    text-decoration:none;
    font-weight:bold;
}

.login-text a:hover{
    text-decoration:underline;
}
</style>
</head>

<body>

<div class="container">
<h2>User Registration</h2>



<form action="signup.jsp" method="post">
   
    <input type="text" name="name"  placeholder="Full Name"required>

    
    <input type="email" name="email" placeholder="Email" required>

    
    <input type="password" name="password" placeholder="Password" required>

    
    <input type="tel" name="contact" placeholder="Contact" required>

    <div class="radio-group">
        Register as :
        <input type="radio" name="role" value="employee" required> Employee
        <input type="radio" name="role" value="admin"> Admin
    </div>

    <button>Register</button>

    <p class="login-text">
        Already have an account? 
        <a href="login.jsp">Login</a>
    </p>
</form>

</div>

</body>
</html>

<%


String name=request.getParameter("name");
String email=request.getParameter("email");
String password=request.getParameter("password");
String number=request.getParameter("contact");
String role=request.getParameter("role");

if(request.getMethod().equals("POST")){
    try{
        long contact=Long.parseLong(number);
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/complaintsystem","root","root");

        PreparedStatement stmt=conn.prepareStatement(
        "INSERT INTO users(name,email,password,phone,role) VALUES(?,?,?,?,?)");

        stmt.setString(1,name);
        stmt.setString(2,email);
        stmt.setString(3,password);
        stmt.setLong(4,contact);
        stmt.setString(5,role);

        int i=stmt.executeUpdate();
    }
    catch(Exception e){
    		e.printStackTrace();
    }

        
 
}
%>
 