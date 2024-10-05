<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Crear Cita Médica</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container mt-5">
    <a href="ListadoCitas.jsp" class="btn btn-secondary mb-3">
        <i class="fas fa-arrow-left"></i> Volver
    </a>

    <h2>Crear Cita Médica</h2>
    <form method="post" action="CrearCitaMedica.jsp">
        <div class="mb-3">
            <label for="medico_id" class="form-label">Médico</label>
            <select class="form-select" name="medico_id" required>
                <%
                    String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566";
                    String user = "sql10735566";
                    String password = "u9xMt5EqYQ";
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);
                        String query = "SELECT id, nombre, apellido FROM medicos";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {
                %>
                    <option value="<%= rs.getInt("id") %>">
                        <%= rs.getString("nombre") + " " + rs.getString("apellido") %>
                    </option>
                <%
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </select>
        </div>
        <div class="mb-3">
            <label for="fecha" class="form-label">Fecha</label>
            <input type="date" class="form-control" name="fecha" required>
        </div>
        <div class="mb-3">
            <label for="hora" class="form-label">Hora</label>
            <input type="time" class="form-control" name="hora" required>
        </div>
        <button type="submit" class="btn btn-primary">Crear</button>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String medico_id = request.getParameter("medico_id");
            String fecha = request.getParameter("fecha");
            String hora = request.getParameter("hora");

            Connection connCrear = null;
            PreparedStatement pstmtCrear = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connCrear = DriverManager.getConnection(url, user, password);
                String insertQuery = "INSERT INTO citas_medica (medico_id, fecha, hora, estado) VALUES (?, ?, ?, ?)";
                pstmtCrear = connCrear.prepareStatement(insertQuery);
                pstmtCrear.setInt(1, Integer.parseInt(medico_id));
                pstmtCrear.setDate(2, Date.valueOf(fecha));

                // Asegúrate de que el campo 'hora' esté en el formato correcto
                if (hora != null && !hora.isEmpty()) {
                    hora = hora + ":00"; // Agregar segundos si no se incluyen
                    pstmtCrear.setTime(3, Time.valueOf(hora));
                } else {
                    throw new IllegalArgumentException("La hora no puede estar vacía.");
                }

                pstmtCrear.setBoolean(4, false); // Estado por defecto a "Pendiente"
                pstmtCrear.executeUpdate();
                response.sendRedirect("ListadoCitas.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } catch (IllegalArgumentException e) {
                out.println("<div class='alert alert-danger'>" + e.getMessage() + "</div>");
            } finally {
                try {
                    if (pstmtCrear != null) pstmtCrear.close();
                    if (connCrear != null) connCrear.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
