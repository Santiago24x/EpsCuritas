<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Eliminar Médico</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Eliminar Médico</h2>
    <%
        String id = request.getParameter("id");
        String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566"; // Cambiado
        String user = "sql10735566"; // Cambiado
        String password = "u9xMt5EqYQ"; // Cambiado
        Connection conn = null;
        PreparedStatement pstmt = null;

        // Proceso de eliminación
        if (id != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                String query = "DELETE FROM medicos WHERE id=?";
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, Integer.parseInt(id));
                pstmt.executeUpdate();
                response.sendRedirect("ListadoMedicos.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
    <p>El médico ha sido eliminado exitosamente.</p>
    <a href="ListadoMedicos.jsp" class="btn btn-primary">Volver al Listado</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
