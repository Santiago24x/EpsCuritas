<%@ page import="java.sql.*" %>
<%
    Integer userId = (Integer) request.getSession().getAttribute("userId");
    String estadoCivil = request.getParameter("estado_civil"); // Asegúrate de que coincida con el nombre en el formulario
    String direccion = request.getParameter("direccion");
    String celular = request.getParameter("celular");
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");

    Connection conn = null;
    PreparedStatement ps = null;
    boolean updateSuccess = false;

    try {
        // Establecer conexión a la base de datos
        conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

        // Actualizar los datos del usuario
        ps = conn.prepareStatement("UPDATE clientes SET estado_civil = ?, direccion = ?, celular = ?, correo = ?, contrasena = ? WHERE id = ?");
        ps.setString(1, estadoCivil);
        ps.setString(2, direccion);
        ps.setString(3, celular);
        ps.setString(4, correo);
        ps.setString(5, contrasena);
        ps.setInt(6, userId);
        
        updateSuccess = ps.executeUpdate() > 0; // Verificar si se actualizó algún registro
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Actualización de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card text-center">
            <div class="card-body">
                <% if (updateSuccess) { %>
                    <i class="bi bi-check-circle" style="font-size: 4rem; color: green;"></i>
                    <h1 class="card-title">Datos Actualizados</h1>
                    <p class="card-text">Los datos del usuario han sido actualizados exitosamente.</p>
                <% } else { %>
                    <i class="bi bi-exclamation-circle" style="font-size: 4rem; color: red;"></i>
                    <h1 class="card-title">Error en la Actualización</h1>
                    <p class="card-text">Hubo un problema al actualizar los datos del usuario.</p>
                <% } %>
                <a href="../IndexCliente.jsp" class="btn btn-primary">Volver al inicio</a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
