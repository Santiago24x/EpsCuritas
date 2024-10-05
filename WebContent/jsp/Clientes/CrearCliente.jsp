<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Crear Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container mt-5">
    <a href="ListadoClientes.jsp" class="btn btn-secondary mb-3">
        <i class="fas fa-arrow-left"></i> Volver
    </a>
    <h2>Crear Cliente</h2>
    <form method="post" action="CrearCliente.jsp">
        <div class="mb-3">
            <label for="cedula" class="form-label">Cédula</label>
            <input type="text" class="form-control" name="cedula" required>
        </div>
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre" required>
        </div>
        <div class="mb-3">
            <label for="apellido" class="form-label">Apellido</label>
            <input type="text" class="form-control" name="apellido" required>
        </div>
        <div class="mb-3">
            <label for="correo" class="form-label">Correo</label>
            <input type="email" class="form-control" name="correo" required>
        </div>
        <div class="mb-3">
            <label for="contrasena" class="form-label">Contraseña</label>
            <input type="password" class="form-control" name="contrasena" required>
        </div>
        <div class="mb-3">
            <label for="celular" class="form-label">Celular</label>
            <input type="text" class="form-control" name="celular" required>
        </div>
        <div class="mb-3">
            <label for="direccion" class="form-label">Dirección</label>
            <input type="text" class="form-control" name="direccion">
        </div>
        <div class="mb-3">
            <label for="estado_civil" class="form-label">Estado Civil</label>
            <select class="form-select" name="estado_civil" required>
                <option value="Soltero">Soltero</option>
                <option value="Casado">Casado</option>
                <option value="Divorciado">Divorciado</option>
                <option value="Viudo">Viudo</option>
                <option value="Otro">Otro</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Crear</button>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String cedula = request.getParameter("cedula");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String correo = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");
            String celular = request.getParameter("celular");
            String direccion = request.getParameter("direccion");
            String estado_civil = request.getParameter("estado_civil");

            String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566";
            String user = "sql10735566";
            String password = "u9xMt5EqYQ";
            Connection connCrear = null;
            PreparedStatement pstmtCrear = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connCrear = DriverManager.getConnection(url, user, password);
                String insertQuery = "INSERT INTO clientes (cedula, nombre, apellido, correo, contrasena, celular, direccion, estado_civil) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                pstmtCrear = connCrear.prepareStatement(insertQuery);
                pstmtCrear.setString(1, cedula);
                pstmtCrear.setString(2, nombre);
                pstmtCrear.setString(3, apellido);
                pstmtCrear.setString(4, correo);
                pstmtCrear.setString(5, contrasena);
                pstmtCrear.setString(6, celular);
                pstmtCrear.setString(7, direccion);
                pstmtCrear.setString(8, estado_civil);
                pstmtCrear.executeUpdate();
                response.sendRedirect("ListadoClientes.jsp");
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger'>Error al crear el cliente: " + e.getMessage() + "</div>");
            } catch (ClassNotFoundException e) {
                out.println("<div class='alert alert-danger'>Error en el controlador de la base de datos: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (pstmtCrear != null) pstmtCrear.close();
                    if (connCrear != null) connCrear.close();
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
