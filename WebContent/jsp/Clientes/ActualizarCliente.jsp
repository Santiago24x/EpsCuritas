<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Actualizar Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container mt-5">
    <a href="ListadoClientes.jsp" class="btn btn-secondary mb-3">
        <i class="fas fa-arrow-left"></i> Volver
    </a>
    <h2>Actualizar Cliente</h2>

    <%
        String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566";
        String user = "sql10735566";
        String password = "u9xMt5EqYQ";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Obtener ID del cliente a actualizar
        String clienteId = request.getParameter("id");
        String nombre = "";
        String apellido = "";
        String correo = "";
        String celular = "";
        String direccion = "";
        String estado_civil = "";

        // Cargar datos del cliente
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            String selectQuery = "SELECT * FROM clientes WHERE id = ?";
            pstmt = conn.prepareStatement(selectQuery);
            pstmt.setInt(1, Integer.parseInt(clienteId));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                nombre = rs.getString("nombre");
                apellido = rs.getString("apellido");
                correo = rs.getString("correo");
                celular = rs.getString("celular");
                direccion = rs.getString("direccion");
                estado_civil = rs.getString("estado_civil");
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

    <form method="post" action="ActualizarCliente.jsp?id=<%= clienteId %>">
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre" value="<%= nombre %>" required>
        </div>
        <div class="mb-3">
            <label for="apellido" class="form-label">Apellido</label>
            <input type="text" class="form-control" name="apellido" value="<%= apellido %>" required>
        </div>
        <div class="mb-3">
            <label for="correo" class="form-label">Correo</label>
            <input type="email" class="form-control" name="correo" value="<%= correo %>" required>
        </div>
        <div class="mb-3">
            <label for="celular" class="form-label">Celular</label>
            <input type="text" class="form-control" name="celular" value="<%= celular %>" required>
        </div>
        <div class="mb-3">
            <label for="direccion" class="form-label">Dirección</label>
            <input type="text" class="form-control" name="direccion" value="<%= direccion %>">
        </div>
        <div class="mb-3">
            <label for="estado_civil" class="form-label">Estado Civil</label>
            <select class="form-select" name="estado_civil" required>
                <option value="Soltero" <%= estado_civil.equals("Soltero") ? "selected" : "" %>>Soltero</option>
                <option value="Casado" <%= estado_civil.equals("Casado") ? "selected" : "" %>>Casado</option>
                <option value="Divorciado" <%= estado_civil.equals("Divorciado") ? "selected" : "" %>>Divorciado</option>
                <option value="Viudo" <%= estado_civil.equals("Viudo") ? "selected" : "" %>>Viudo</option>
                <option value="Otro" <%= estado_civil.equals("Otro") ? "selected" : "" %>>Otro</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Actualizar</button>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String nuevoNombre = request.getParameter("nombre");
            String nuevoApellido = request.getParameter("apellido");
            String nuevoCorreo = request.getParameter("correo");
            String nuevoCelular = request.getParameter("celular");
            String nuevaDireccion = request.getParameter("direccion");
            String nuevoEstadoCivil = request.getParameter("estado_civil");

            Connection connActualizar = null;
            PreparedStatement pstmtActualizar = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connActualizar = DriverManager.getConnection(url, user, password);
                String updateQuery = "UPDATE clientes SET nombre = ?, apellido = ?, correo = ?, celular = ?, direccion = ?, estado_civil = ? WHERE id = ?";
                pstmtActualizar = connActualizar.prepareStatement(updateQuery);
                pstmtActualizar.setString(1, nuevoNombre);
                pstmtActualizar.setString(2, nuevoApellido);
                pstmtActualizar.setString(3, nuevoCorreo);
                pstmtActualizar.setString(4, nuevoCelular);
                pstmtActualizar.setString(5, nuevaDireccion);
                pstmtActualizar.setString(6, nuevoEstadoCivil);
                pstmtActualizar.setInt(7, Integer.parseInt(clienteId));
                pstmtActualizar.executeUpdate();
                response.sendRedirect("ListadoClientes.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (pstmtActualizar != null) pstmtActualizar.close();
                    if (connActualizar != null) connActualizar.close();
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
