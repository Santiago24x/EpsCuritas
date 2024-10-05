<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Citas Médicas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container mt-5">

    <a href="../IndexAdministrador.jsp" class="btn btn-secondary mb-3">
        <i class="fas fa-arrow-left"></i> Volver
    </a>
    
    <h1 class="text-center">Listado de Citas Médicas</h1>
    
    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Médico</th>
            <th>Fecha</th>
            <th>Hora</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566";
            String user = "sql10735566";
            String password = "u9xMt5EqYQ";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                String query = "SELECT cm.id, m.nombre, m.apellido, cm.fecha, cm.hora, cm.estado " +
                               "FROM citas_medica cm " +
                               "JOIN medicos m ON cm.medico_id = m.id";
                pstmt = conn.prepareStatement(query);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String medico = rs.getString("nombre") + " " + rs.getString("apellido");
                    java.sql.Date fecha = rs.getDate("fecha");
                    Time hora = rs.getTime("hora");
                    boolean estado = rs.getBoolean("estado");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= medico %></td>
            <td><%= fecha %></td>
            <td><%= hora %></td>
            <td><%= estado ? "Asignada" : "Pendiente" %></td>
            <td>
                <a href="ActualizarCitaMedica.jsp?id=<%= id %>" class="btn btn-warning btn-sm">Editar</a>
                <a href="EliminarCitaMedica.jsp?id=<%= id %>" class="btn btn-danger btn-sm">Eliminar</a>
            </td>
        </tr>
        <%
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        </tbody>
    </table>
    <a href="CrearCitaMedica.jsp" class="btn btn-primary mb-3">Crear Cita Médica</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
