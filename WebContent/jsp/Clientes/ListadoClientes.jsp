<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container mt-5">

    <a href="../IndexAdministrador.jsp" class="btn btn-secondary mb-3">
        <i class="fas fa-arrow-left"></i> Volver
    </a>
    
    <h1 class="text-center">Listado de Clientes</h1>
    
    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Cédula</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Correo</th>
            <th>Celular</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566"; // Actualiza el nombre de la base de datos aquí
            String user = "sql10735566"; // Actualiza el usuario aquí
            String password = "u9xMt5EqYQ"; // Actualiza la contraseña aquí

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                String query = "SELECT * FROM clientes";
                pstmt = conn.prepareStatement(query);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String cedula = rs.getString("cedula");
                    String nombre = rs.getString("nombre");
                    String apellido = rs.getString("apellido");
                    String correo = rs.getString("correo");
                    String celular = rs.getString("celular");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= cedula %></td>
            <td><%= nombre %></td>
            <td><%= apellido %></td>
            <td><%= correo %></td>
            <td><%= celular %></td>
            <td>
                <a href="ActualizarCliente.jsp?id=<%= id %>" class="btn btn-warning btn-sm">Editar</a>
                <a href="EliminarCliente.jsp?id=<%= id %>" class="btn btn-danger btn-sm">Eliminar</a>
            </td>
        </tr>
        <%
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
        </tbody>
    </table>
    <a href="CrearCliente.jsp" class="btn btn-primary mb-3">Crear Cliente</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
