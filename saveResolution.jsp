<%@page import="java.sql.*"%>
<%
String role=(String) session.getAttribute("role");
if(role==null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
}

String cid=request.getParameter("cid");
String resolution=request.getParameter("resolution");

if(cid!=null && resolution!=null){

    Class.forName("com.mysql.cj.jdbc.Driver");
    String url="jdbc:mysql://localhost:3306/complaintsystem?user=root&&password=root";
    Connection conn=DriverManager.getConnection(url);

    String query="UPDATE complaints SET status='Resolved', admin_remark=?, resolved_at=NOW() WHERE complaint_id=?";
    PreparedStatement stmt=conn.prepareStatement(query);
    stmt.setString(1,resolution);
    stmt.setInt(2,Integer.parseInt(cid));
    stmt.executeUpdate();

    conn.close();
}


%>