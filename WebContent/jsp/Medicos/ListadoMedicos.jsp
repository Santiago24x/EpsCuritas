<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Listado de Médicos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container mt-5">
    <a href="../IndexAdministrador.jsp" class="btn btn-secondary mb-3">
        <i class="fas fa-arrow-left"></i> Volver
    </a>
    <h1>Listado de Médicos</h1>
    
    <table class="table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Cédula</th>
                <th>Apellido</th>
                <th>Nombre</th>
                <th>Especialidad</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <%
            String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566"; // Cambiado
            String user = "sql10735566"; // Cambiado
            String password = "u9xMt5EqYQ"; // Cambiado
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                stmt = conn.createStatement();
                String query = "SELECT * FROM medicos";
                rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String cedula = rs.getString("cedula");
                    String apellido = rs.getString("apellido");
                    String nombre = rs.getString("nombre");
                    String especialidad = rs.getString("especialidad");
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= cedula %></td>
                        <td><%= apellido %></td>
                        <td><%= nombre %></td>
                        <td><%= especialidad %></td>
                        <td>
                            <a href="ActualizarMedico.jsp?id=<%= id %>" class="btn btn-warning">Actualizar</a>
                            <a href="EliminarMedico.jsp?id=<%= id %>" class="btn btn-danger">Eliminar</a>
                        </td>
                    </tr>
        <%
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
        </tbody>
    </table>
    <a href="CrearMedico.jsp" class="btn btn-primary mb-3">Agregar Médico</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
