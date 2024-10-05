<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Actualizar Médico</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container mt-5">
    <a href="ListadoMedicos.jsp" class="btn btn-secondary mb-3">
        <i class="fas fa-arrow-left"></i> Volver
    </a>
    <h2>Actualizar Médico</h2>
    <%
        String id = request.getParameter("id");
        String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566"; // Cambiado
        String user = "sql10735566"; // Cambiado
        String password = "u9xMt5EqYQ"; // Cambiado
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String cedula = "";
        String apellido = "";
        String nombre = "";
        String especialidad = "";

        // Obtener los datos del médico para mostrarlos en el formulario
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            String query = "SELECT * FROM medicos WHERE id=?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(id));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                cedula = rs.getString("cedula");
                apellido = rs.getString("apellido");
                nombre = rs.getString("nombre");
                especialidad = rs.getString("especialidad");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <form method="post" action="ActualizarMedico.jsp?id=<%= id %>">
        <div class="mb-3">
            <label for="cedula" class="form-label">Cédula</label>
            <input type="text" class="form-control" name="cedula" value="<%= cedula %>" required>
        </div>
        <div class="mb-3">
            <label for="apellido" class="form-label">Apellido</label>
            <input type="text" class="form-control" name="apellido" value="<%= apellido %>" required>
        </div>
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre" value="<%= nombre %>" required>
        </div>
        <div class="mb-3">
            <label for="especialidad" class="form-label">Especialidad</label>
            <select class="form-select" name="especialidad" required>
                <option value="Microbiología" <%= especialidad.equals("Microbiología") ? "selected" : "" %>>Microbiología</option>
                <option value="Cardiología" <%= especialidad.equals("Cardiología") ? "selected" : "" %>>Cardiología</option>
                <option value="Pediatría" <%= especialidad.equals("Pediatría") ? "selected" : "" %>>Pediatría</option>
                <option value="Dermatología" <%= especialidad.equals("Dermatología") ? "selected" : "" %>>Dermatología</option>
                <option value="Medicina General" <%= especialidad.equals("Medicina General") ? "selected" : "" %>>Medicina General</option>
                <option value="Internista" <%= especialidad.equals("Internista") ? "selected" : "" %>>Internista</option>
            </select>
        </div>
        <button type="submit" class="btn btn-warning">Actualizar</button>
    </form>

    <%
        // Proceso de actualización
        if (request.getMethod().equalsIgnoreCase("POST")) {
            cedula = request.getParameter("cedula");
            apellido = request.getParameter("apellido");
            nombre = request.getParameter("nombre");
            especialidad = request.getParameter("especialidad");

            // Actualizar en la base de datos
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                String query = "UPDATE medicos SET cedula=?, apellido=?, nombre=?, especialidad=? WHERE id=?";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, cedula);
                pstmt.setString(2, apellido);
                pstmt.setString(3, nombre);
                pstmt.setString(4, especialidad);
                pstmt.setInt(5, Integer.parseInt(id));
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
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
