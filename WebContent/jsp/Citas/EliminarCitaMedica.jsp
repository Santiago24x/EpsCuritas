<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566";
    String user = "sql10735566";
    String password = "u9xMt5EqYQ";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        String deleteQuery = "DELETE FROM citas_medica WHERE id=?";
        pstmt = conn.prepareStatement(deleteQuery);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        response.sendRedirect("ListadoCitas.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
