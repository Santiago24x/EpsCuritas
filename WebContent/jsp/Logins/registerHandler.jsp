<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>
<%
String nombre = request.getParameter("nombre");
String apellido = request.getParameter("apellido");
String cedula = request.getParameter("cedula");
String correo = request.getParameter("correo");
String contrasena = request.getParameter("contrasena");
String celular = request.getParameter("celular");
String direccion = request.getParameter("direccion");
String estadoCivil = request.getParameter("estado_civil");

// Establecer conexión a la base de datos
Connection conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

// Verificar si el correo o la cédula ya existen
PreparedStatement checkPs = conn.prepareStatement("SELECT COUNT(*) FROM clientes WHERE correo = ? OR cedula = ?");
checkPs.setString(1, correo);
checkPs.setString(2, cedula);
ResultSet rs = checkPs.executeQuery();
rs.next();
int count = rs.getInt(1);

StringBuilder message = new StringBuilder();
String alertClass = "";
String icon = "";

if (count > 0) {
    // Si el correo o la cédula ya existen, muestra un mensaje de error
    alertClass = "alert-danger";
    icon = "<i class='bi bi-exclamation-triangle-fill'></i>";
    if (rs.getInt(1) > 0) {
        message.append("El correo ya está registrado. ");
    }
    if (rs.getInt(2) > 0) {
        message.append("La cédula ya está registrada.");
    }
} else {
    // Si no existen, inserta el nuevo cliente
    PreparedStatement ps = conn.prepareStatement("INSERT INTO clientes (nombre, apellido, cedula, correo, contrasena, celular, direccion, estado_civil, rol_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1)");
    ps.setString(1, nombre);
    ps.setString(2, apellido);
    ps.setString(3, cedula);
    ps.setString(4, correo);
    ps.setString(5, contrasena); // Asegúrate de hacer hash a la contraseña aquí si es necesario
    ps.setString(6, celular);
    ps.setString(7, direccion);
    ps.setString(8, estadoCivil);
    
    try {
        int resultado = ps.executeUpdate();
        alertClass = "alert-success";
        icon = "<i class='bi bi-check-circle-fill'></i>";
        message.append("Registro exitoso. <a href='Login.jsp' class='alert-link'>Iniciar sesión</a>");
    } catch (SQLException e) {
        alertClass = "alert-danger";
        icon = "<i class='bi bi-exclamation-triangle-fill'></i>";
        message.append("Error al registrar. <a href='Register.jsp' class='alert-link'>Intenta de nuevo</a>");
    }
}

conn.close();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado de Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
        .message-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
    <div class="container message-container">
        <div class="alert <%= alertClass %> text-center" role="alert">
            <%= icon %> <%= message.toString() %>
        </div>
    </div>
</body>
</html>
