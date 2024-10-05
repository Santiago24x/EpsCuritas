<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, java.util.List, java.util.ArrayList" %>
<%
    // Obtener la sesión y el ID del usuario
    HttpSession userSession = request.getSession();
    Integer userId = (Integer) userSession.getAttribute("userId");

    // Validar si el usuario está logueado
    if (userId == null) {
        response.sendRedirect("../Logins/Login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    List<String[]> citas = new ArrayList<>(); // Lista para almacenar las citas

    try {
        // Establecer conexión a la base de datos
        conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

        // Obtener la fecha y hora actuales
        String currentDateTime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

        // Obtener citas médicas que están en el futuro y con estado 0 (disponibles)
        ps = conn.prepareStatement("SELECT c.id, c.fecha, c.hora, d.nombre AS doctor_nombre " +
                                    "FROM citas_medica c " +
                                    "JOIN medicos d ON c.medico_id = d.id " +
                                    "WHERE c.estado = 0 AND CONCAT(c.fecha, ' ', c.hora) > ?");
        ps.setString(1, currentDateTime);
        rs = ps.executeQuery();

        while (rs.next()) {
            String[] citaInfo = new String[4]; // Incluye el ID de la cita
            citaInfo[0] = rs.getString("id"); // ID de la cita
            citaInfo[1] = rs.getString("fecha");
            citaInfo[2] = rs.getString("hora");
            citaInfo[3] = rs.getString("doctor_nombre");
            citas.add(citaInfo); // Añadir a la lista de citas
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Cerrar recursos
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicitar Citas Medicas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        function showConfirmation() {
            document.getElementById('confirmationCard').style.display = 'block';
        }
    </script>
</head>
<body>
    <div class="container mt-5">

        <a href="../IndexCliente.jsp" class="btn btn-secondary mb-3">
            <i class="fas fa-arrow-left"></i> Volver
        </a>
        
        <h1 class="mb-4 text-center">Solicitar Citas Medicas</h1>
        <div class="list-group">
            <% for (String[] cita : citas) { %>
                <div class="list-group-item">
                    <div>
                        <strong>Fecha:</strong> <%= cita[1] %><br>
                        <strong>Hora:</strong> <%= cita[2] %><br>
                        <strong>Doctor:</strong> <%= cita[3] %>
                    </div>
                    <form method="post" action="AsignarCita.jsp">
                        <input type="hidden" name="citaId" value="<%= cita[0] %>"> <!-- Enviar el ID real de la cita -->
                        <button type="submit" class="btn btn-success btn-sm float-end" onclick="showConfirmation()">Seleccionar</button>
                    </form>
                </div>
            <% } %>
        </div>

        <!-- Tarjeta de confirmación (opcional) -->
        <div class="card mt-4" id="confirmationCard" style="display:none;">
            <div class="card-body text-center">
                <i class="bi bi-check-circle" style="font-size: 3rem; color: green;"></i>
                <h5 class="card-title">Cita Asignada</h5>
                <p>Su cita ha sido asignada exitosamente.</p>
                <a href="../IndexCliente.jsp" class="btn btn-primary">Volver al índice</a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
