<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    // Obtener el ID de la cita de laboratorio y el ID del cliente de la sesión
    String laboratorioId = request.getParameter("laboratorioId");
    Integer userId = (Integer) request.getSession().getAttribute("userId");

    // Validar que la cita de laboratorio y el usuario estén definidos
    if (laboratorioId == null || userId == null) {
        response.sendRedirect("../Logins/Login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    try {
        // Conectar a la base de datos remota
        conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

        // Actualizar el estado de la cita de laboratorio a 1 (asignada) en la tabla laboratorios
        ps = conn.prepareStatement("UPDATE laboratorios SET estado = 1 WHERE id = ?");
        ps.setString(1, laboratorioId);
        int updatedRows = ps.executeUpdate();

        if (updatedRows > 0) {
            // Insertar la relación en la tabla cliente_laboratorio (asignar la cita de laboratorio al cliente)
            ps = conn.prepareStatement("INSERT INTO cliente_laboratorio (cliente_id, laboratorio_id) VALUES (?, ?)");
            ps.setInt(1, userId);
            ps.setString(2, laboratorioId);
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
    <title>Cita de Laboratorio Asignada</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card text-center">
            <div class="card-body">
                <i class="bi bi-check-circle" style="font-size: 4rem; color: green;"></i>
                <h1 class="card-title">Cita de Laboratorio Asignada</h1>
                <p class="card-text">La cita de laboratorio ha sido asignada exitosamente.</p>
                <a href="../IndexCliente.jsp" class="btn btn-primary">Volver al inicio</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
