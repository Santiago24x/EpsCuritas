<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    // Obtener el ID de la cita y el ID del cliente de la sesión
    String citaId = request.getParameter("citaId");
    Integer userId = (Integer) request.getSession().getAttribute("userId");

    // Validar que la cita y el usuario estén definidos
    if (citaId == null || userId == null) {
        response.sendRedirect("../Logins/Login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    try {
        // Conectar a la base de datos remota
        conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

        // Actualizar el estado de la cita a 1 (asignada) en la tabla citas_medica
        ps = conn.prepareStatement("UPDATE citas_medica SET estado = 1 WHERE id = ?");
        ps.setString(1, citaId);
        int updatedRows = ps.executeUpdate();

        if (updatedRows > 0) {
            // Insertar la relación en la tabla cliente_cita_medica (asignar la cita al cliente)
            ps = conn.prepareStatement("INSERT INTO cliente_cita_medica (cliente_id, cita_medica_id) VALUES (?, ?)");
            ps.setInt(1, userId);
            ps.setString(2, citaId);
            ps.executeUpdate();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Cerrar la conexión
        if (ps != null) try { ps.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cita Asignada</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card text-center">
            <div class="card-body">
                <i class="bi bi-check-circle" style="font-size: 4rem; color: green;"></i>
                <h1 class="card-title">Cita Asignada</h1>
                <p class="card-text">La cita ha sido asignada exitosamente.</p>
                <a href="../IndexCliente.jsp" class="btn btn-primary">Volver al inicio</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
