<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UpdateStatus</title>
</head>
<body>
	<%
		String role=(String) session.getAttribute("role");
		if(role==null || !role.equals("admin"))
			response.sendRedirect("adminHome.jsp");
		
		String cid=request.getParameter("cid");
		String action=request.getParameter("action");

	if(cid!=null && action!=null){
		int complaint_id=Integer.parseInt(cid);
		
		String status="";
		String admin_remark="";
		if(action.equals("reject")){
			status="Rejected";
			admin_remark="Rejected by Admin";
		}
		if(action.equals("resolve")){
			status="Resolved";
			admin_remark="Provided Solution";
		}
		if(action.equals("Cancelled")){
			admin_remark="Cancelled by user";
			
		}
			
		
		 Class.forName("com.mysql.cj.jdbc.Driver");
		 String url="jdbc:mysql://localhost:3306/complaintsystem?user=root&&password=root";
		 Connection conn=DriverManager.getConnection(url);
		 
		 String query="UPDATE complaints SET status=?,admin_remark=?, resolved_at=NOW() where complaint_id=?";
		 PreparedStatement stmt=conn.prepareStatement(query);
		 stmt.setString(1,status);
		 stmt.setInt(2,complaint_id);
		 stmt.setString(3,admin_remark);
		 stmt.executeUpdate();
		 
	 }
	
	
	%>
	

</body>
</html>