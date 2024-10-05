<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Crear Médico</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container mt-5">
    <a href="ListadoMedicos.jsp" class="btn btn-secondary mb-3">
        <i class="fas fa-arrow-left"></i> Volver
    </a>
    <h2>Crear Médico</h2>
    <form method="post" action="CrearMedico.jsp">
        <div class="mb-3">
            <label for="cedula" class="form-label">Cédula</label>
            <input type="text" class="form-control" name="cedula" required>
        </div>
        <div class="mb-3">
            <label for="apellido" class="form-label">Apellido</label>
            <input type="text" class="form-control" name="apellido" required>
        </div>
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre" required>
        </div>
        <div class="mb-3">
            <label for="especialidad" class="form-label">Especialidad</label>
            <select class="form-select" name="especialidad" required>
                <option value="Microbiología">Microbiología</option>
                <option value="Cardiología">Cardiología</option>
                <option value="Pediatría">Pediatría</option>
                <option value="Dermatología">Dermatología</option>
                <option value="Medicina General">Medicina General</option>
                <option value="Internista">Internista</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Crear</button>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String cedula = request.getParameter("cedula");
            String apellido = request.getParameter("apellido");
            String nombre = request.getParameter("nombre");
            String especialidad = request.getParameter("especialidad");

            String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566"; // Cambiado
            String user = "sql10735566"; // Cambiado
            String password = "u9xMt5EqYQ"; // Cambiado
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                String query = "INSERT INTO medicos (cedula, apellido, nombre, especialidad) VALUES (?, ?, ?, ?)";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, cedula);
                pstmt.setString(2, apellido);
                pstmt.setString(3, nombre);
                pstmt.setString(4, especialidad);
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

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
