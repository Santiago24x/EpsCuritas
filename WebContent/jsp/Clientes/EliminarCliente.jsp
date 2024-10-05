<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566"; // Actualiza el nombre de la base de datos aquí
    String user = "sql10735566"; // Actualiza el usuario aquí
    String password = "u9xMt5EqYQ"; // Actualiza la contraseña aquí

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        String query = "DELETE FROM clientes WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
        response.sendRedirect("ListadoClientes.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
