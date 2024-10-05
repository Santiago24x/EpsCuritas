<%@ page import="java.sql.*" %>
<%
    Integer userId = (Integer) request.getSession().getAttribute("userId");
    String nombre = "", apellido = "", estadoCivil = "", direccion = "", celular = "", correo = "", contrasena = "";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Establecer conexión a la base de datos
        conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

        // Obtener datos del usuario
        ps = conn.prepareStatement("SELECT * FROM clientes WHERE id = ?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();

        if (rs.next()) {
            nombre = rs.getString("nombre");
            apellido = rs.getString("apellido");
            estadoCivil = rs.getString("estado_civil");
            direccion = rs.getString("direccion");
            celular = rs.getString("celular");
            correo = rs.getString("correo");
            contrasena = rs.getString("contrasena");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // Puedes agregar un mensaje de error para mostrar al usuario
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (ps != null) try { ps.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Actualizar Datos de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Actualizar Datos de Usuario</h2>
        <form action="ActualizarDatosUsuario.jsp" method="post">
            <div class="form-group">
                <label>Nombre</label>
                <input type="text" class="form-control" name="nombre" value="<%= nombre %>" required>
            </div>
            <div class="form-group">
                <label>Apellido</label>
                <input type="text" class="form-control" name="apellido" value="<%= apellido %>" required>
            </div>
            <div class="form-group">
                <label>Estado Civil</label>
                <input type="text" class="form-control" name="estado_civil" value="<%= estadoCivil %>">
            </div>
            <div class="form-group">
                <label>Dirección</label>
                <input type="text" class="form-control" name="direccion" value="<%= direccion %>">
            </div>
            <div class="form-group">
                <label>Celular</label>
                <input type="text" class="form-control" name="celular" value="<%= celular %>">
            </div>
            <div class="form-group">
                <label>Correo Electrónico</label>
                <input type="email" class="form-control" name="correo" value="<%= correo %>">
            </div>
            <div class="form-group">
                <label>Contraseña</label>
                <input type="password" class="form-control" name="contrasena" value="<%= contrasena %>">
            </div>
            <button type="submit" class="btn btn-primary">Actualizar</button>
            <a href="../IndexCliente.jsp" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
