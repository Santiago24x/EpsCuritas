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
    List<String[]> citasLaboratorio = new ArrayList<>(); // Lista para almacenar las citas de laboratorio

    try {
        // Establecer conexión a la base de datos
        conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

        // Obtener citas de laboratorio disponibles (estado = 0) en el futuro, incluyendo tipo de laboratorio y el nombre completo del doctor
        ps = conn.prepareStatement("SELECT l.id, l.fecha, l.hora, l.tipo_laboratorio, CONCAT(d.nombre, ' ', d.apellido) AS doctor_nombre " +
                                    "FROM laboratorios l " +
                                    "JOIN medicos d ON l.medico_id = d.id " +
                                    "WHERE l.estado = 0 AND CONCAT(l.fecha, ' ', l.hora) > ?");
        String currentDateTime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
        ps.setString(1, currentDateTime);
        rs = ps.executeQuery();

        while (rs.next()) {
            String[] citaInfo = new String[5]; // Incluye el ID, tipo de laboratorio, fecha, hora, y nombre completo del doctor
            citaInfo[0] = rs.getString("id"); // ID de la cita de laboratorio
            citaInfo[1] = rs.getString("fecha");
            citaInfo[2] = rs.getString("hora");
            citaInfo[3] = rs.getString("tipo_laboratorio"); // Tipo de laboratorio
            citaInfo[4] = rs.getString("doctor_nombre"); // Nombre y apellido del doctor
            citasLaboratorio.add(citaInfo); // Añadir a la lista de citas
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
    <title>Solicitar Citas de Laboratorio</title>
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

        <h1 class="mb-4 text-center">Solicitar Citas de Laboratorio</h1>
        <div class="list-group">
            <% for (String[] cita : citasLaboratorio) { %>
                <div class="list-group-item">
                    <div>
                        <strong>Fecha:</strong> <%= cita[1] %><br>
                        <strong>Hora:</strong> <%= cita[2] %><br>
                        <strong>Tipo de Laboratorio:</strong> <%= cita[3] %><br> <!-- Tipo de laboratorio -->
                        <strong>Doctor:</strong> <%= cita[4] %> <!-- Nombre completo del doctor -->
                    </div>
                    <form method="post" action="AsignarCitaLaboratorio.jsp">
                        <input type="hidden" name="laboratorioId" value="<%= cita[0] %>"> <!-- Enviar el ID real de la cita de laboratorio -->
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
                <p>Su cita de laboratorio ha sido asignada exitosamente.</p>
                <a href="../IndexCliente.jsp" class="btn btn-primary">Volver al índice</a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
