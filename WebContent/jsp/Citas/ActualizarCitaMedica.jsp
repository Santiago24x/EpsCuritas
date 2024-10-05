<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Actualizar Cita Médica</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container mt-5">
    <a href="ListadoCitas.jsp" class="btn btn-secondary mb-3">
        <i class="fas fa-arrow-left"></i> Volver
    </a>
    <h2>Actualizar Cita Médica</h2>
    <%
        String id = request.getParameter("id");
        String url = "jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566"; // Cambiado a tus credenciales
        String user = "sql10735566"; // Cambiado a tus credenciales
        String password = "u9xMt5EqYQ"; // Cambiado a tus credenciales
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String medico_id = "";
        String fecha = "";
        String hora = "";

        // Obtener los datos de la cita médica para mostrarlos en el formulario
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            String query = "SELECT * FROM citas_medica WHERE id=?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(id));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                medico_id = rs.getString("medico_id");
                fecha = rs.getDate("fecha").toString();
                hora = rs.getTime("hora").toString();
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

    <form method="post" action="ActualizarCitaMedica.jsp?id=<%= id %>">
        <div class="mb-3">
            <label for="medico_id" class="form-label">Médico</label>
            <select class="form-select" name="medico_id" required>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);
                        String query = "SELECT id, nombre, apellido FROM medicos";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {
                            String selected = (rs.getInt("id") == Integer.parseInt(medico_id)) ? "selected" : "";
                %>
                    <option value="<%= rs.getInt("id") %>" <%= selected %> >
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
            <input type="date" class="form-control" name="fecha" value="<%= fecha %>" required>
        </div>
        <div class="mb-3">
            <label for="hora" class="form-label">Hora</label>
            <input type="time" class="form-control" name="hora" value="<%= hora.substring(0,5) %>" required>
        </div>
        <button type="submit" class="btn btn-warning">Actualizar</button>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String nuevo_medico_id = request.getParameter("medico_id");
            String nueva_fecha = request.getParameter("fecha");
            String nueva_hora = request.getParameter("hora");

            // Actualizar en la base de datos
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                String updateQuery = "UPDATE citas_medica SET medico_id=?, fecha=?, hora=? WHERE id=?";
                pstmt = conn.prepareStatement(updateQuery);
                pstmt.setInt(1, Integer.parseInt(nuevo_medico_id));
                pstmt.setDate(2, Date.valueOf(nueva_fecha));
                pstmt.setTime(3, Time.valueOf(nueva_hora + ":00"));
                pstmt.setInt(4, Integer.parseInt(id));
                pstmt.executeUpdate();
                response.sendRedirect("ListadoCitas.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
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
