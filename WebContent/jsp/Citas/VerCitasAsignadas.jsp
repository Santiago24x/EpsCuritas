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
    List<String[]> citasLaboratorio = new ArrayList<>();
    List<String[]> citasMedicina = new ArrayList<>();

    try {
        // Conectar a la base de datos
        conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

        // Obtener citas de laboratorio asignadas al cliente
        ps = conn.prepareStatement("SELECT l.id, l.fecha, l.hora, l.tipo_laboratorio, CONCAT(d.nombre, ' ', d.apellido) AS doctor_nombre " +
                                   "FROM laboratorios l " +
                                   "JOIN medicos d ON l.medico_id = d.id " +
                                   "JOIN cliente_laboratorio cl ON l.id = cl.laboratorio_id " +
                                   "WHERE cl.cliente_id = ?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();
        while (rs.next()) {
            String[] citaLaboratorio = new String[5]; // ID, fecha, hora, tipo, nombre del doctor
            citaLaboratorio[0] = rs.getString("id"); // ID de la cita
            citaLaboratorio[1] = rs.getString("fecha");
            citaLaboratorio[2] = rs.getString("hora");
            citaLaboratorio[3] = rs.getString("tipo_laboratorio");
            citaLaboratorio[4] = rs.getString("doctor_nombre");
            citasLaboratorio.add(citaLaboratorio);
        }
        rs.close();
        ps.close();

        // Obtener citas médicas asignadas al cliente
        ps = conn.prepareStatement("SELECT c.id, c.fecha, c.hora, CONCAT(d.nombre, ' ', d.apellido) AS doctor_nombre " +
                                   "FROM citas_medica c " +
                                   "JOIN medicos d ON c.medico_id = d.id " +
                                   "JOIN cliente_cita_medica cm ON c.id = cm.cita_medica_id " +
                                   "WHERE cm.cliente_id = ?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();
        while (rs.next()) {
            String[] citaMedicina = new String[4]; // ID, fecha, hora, nombre del doctor
            citaMedicina[0] = rs.getString("id");
            citaMedicina[1] = rs.getString("fecha");
            citaMedicina[2] = rs.getString("hora");
            citaMedicina[3] = rs.getString("doctor_nombre");
            citasMedicina.add(citaMedicina);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
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
    <title>Citas Asignadas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

    <div class="container mt-5">
        <a href="../IndexCliente.jsp" class="btn btn-secondary mb-3">
            <i class="fas fa-arrow-left"></i> Volver
        </a>
        <h1 class="mb-4 text-center">Citas Asignadas</h1>

        <!-- Citas de Laboratorio -->
        <h3>Citas de Laboratorio</h3>
        <div class="list-group">
            <% if (citasLaboratorio.isEmpty()) { %>
                <div class="alert alert-info">No tienes citas de laboratorio asignadas.</div>
            <% } else { %>
                <% for (String[] cita : citasLaboratorio) { %>
                    <div class="list-group-item">
                        <strong>Fecha:</strong> <%= cita[1] %><br>
                        <strong>Hora:</strong> <%= cita[2] %><br>
                        <strong>Tipo de Laboratorio:</strong> <%= cita[3] %><br>
                        <strong>Doctor:</strong> <%= cita[4] %><br>
                        <form method="post" action="CancelarCitaLaboratorio.jsp">
                            <input type="hidden" name="laboratorioId" value="<%= cita[0] %>">
                            <button type="submit" class="btn btn-danger btn-sm float-end">Cancelar</button>
                        </form>
                    </div>
                <% } %>
            <% } %>
        </div>

        <!-- Citas Médicas -->
        <h3 class="mt-5">Citas Médicas</h3>
        <div class="list-group">
            <% if (citasMedicina.isEmpty()) { %>
                <div class="alert alert-info">No tienes citas médicas asignadas.</div>
            <% } else { %>
                <% for (String[] cita : citasMedicina) { %>
                    <div class="list-group-item">
                        <strong>Fecha:</strong> <%= cita[1] %><br>
                        <strong>Hora:</strong> <%= cita[2] %><br>
                        <strong>Doctor:</strong> <%= cita[3] %><br>
                        <form method="post" action="CancelarCitaMedica.jsp">
                            <input type="hidden" name="citaId" value="<%= cita[0] %>">
                            <button type="submit" class="btn btn-danger btn-sm float-end">Cancelar</button>
                        </form>
                    </div>
                <% } %>
            <% } %>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
