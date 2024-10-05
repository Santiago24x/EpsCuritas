<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="java.security.MessageDigest" %>
<%
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");

    // Validar entradas
    if (correo == null || contrasena == null || correo.isEmpty() || contrasena.isEmpty()) {
        out.println("<div class='alert alert-danger'>Por favor, complete todos los campos.</div>");
        return; // Salir del script
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Establecer conexión a la base de datos
        conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

        // Hash de la contraseña ingresada
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashedBytes = md.digest(contrasena.getBytes("UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (byte b : hashedBytes) {
            sb.append(String.format("%02x", b));
        }
        String hashedContrasena = sb.toString();

        // Verificar usuario
        ps = conn.prepareStatement("SELECT id, rol_id, nombre FROM clientes WHERE correo = ? AND contrasena = ?");
        ps.setString(1, correo);
        ps.setString(2, hashedContrasena);
        rs = ps.executeQuery();

        if (rs.next()) {
            int userId = rs.getInt("id");
            int rolId = rs.getInt("rol_id");
            String nombreUsuario = rs.getString("nombre"); // Obtener el nombre del usuario

            // Almacenar información del usuario en la sesión
            HttpSession userSession = request.getSession();
            userSession.setAttribute("userId", userId);
            userSession.setAttribute("rolId", rolId);
            userSession.setAttribute("nombreUsuario", nombreUsuario); // Almacenar nombre

            // Redirigir a la página correspondiente según el rol
            if (rolId == 1) { // Rol de Cliente
                response.sendRedirect("../IndexCliente.jsp");
            } else if (rolId == 2) { // Rol de Administrador
                response.sendRedirect("../IndexAdministrador.jsp");
            }
        } else {
            out.println("<div class='alert alert-danger'>Credenciales incorrectas</div>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<div class='alert alert-danger'>Error en la base de datos: " + e.getMessage() + "</div>");
    } finally {
        // Cerrar recursos
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (ps != null) try { ps.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
