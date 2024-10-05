<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Listado de Citas de Laboratorio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container mt-5">
    <a href="../IndexAdministrador.jsp" class="btn btn-secondary mb-3">
        <i class="fas fa-arrow-left"></i> Volver
    </a>

    <h1 class="text-center">Citas de Laboratorio</h1>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Médico</th>
            <th>Tipo de Laboratorio</th>
            <th>Fecha</th>
            <th>Hora</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ"); // Credenciales actualizadas

                String query = "SELECT l.id, m.nombre, m.apellido, l.tipo_laboratorio, l.fecha, l.hora, l.estado " +
                        "FROM laboratorios l " +
                        "JOIN medicos m ON l.medico_id = m.id " +
                        "WHERE m.especialidad = 'Microbiologia'";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String medicoNombre = rs.getString("nombre") + " " + rs.getString("apellido");
                    String tipoLab = rs.getString("tipo_laboratorio");
                    java.sql.Date fecha = rs.getDate("fecha");
                    Time hora = rs.getTime("hora");
                    boolean estado = rs.getBoolean("estado");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= medicoNombre %></td>
            <td><%= tipoLab %></td>
            <td><%= fecha %></td>
            <td><%= hora %></td>
            <td><%= estado ? "Asignada" : "Pendiente" %></td>
            <td>
                <a href="ActualizarLaboratorio.jsp?id=<%= id %>" class="btn btn-warning">Editar</a>
                <a href="EliminarLaboratorio.jsp?id=<%= id %>" class="btn btn-danger">Eliminar</a>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace(); // Puedes reemplazar esto con un manejo de errores más robusto
            } finally {
                // Cerrar recursos en el bloque finally
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
    <a href="CrearLaboratorio.jsp" class="btn btn-primary">Crear nueva cita de laboratorio</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
