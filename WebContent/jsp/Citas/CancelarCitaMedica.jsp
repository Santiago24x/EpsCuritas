<%@ page import="java.sql.*" %>
<%
    // Obtener el ID de la cita médica a cancelar
    String citaId = request.getParameter("citaId");
    Integer userId = (Integer) request.getSession().getAttribute("userId");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Establecer conexión a la base de datos remota
        conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

        // Eliminar la relación entre el cliente y la cita médica
        ps = conn.prepareStatement("DELETE FROM cliente_cita_medica WHERE cliente_id = ? AND cita_medica_id = ?");
        ps.setInt(1, userId);
        ps.setString(2, citaId);
        ps.executeUpdate();
        ps.close();

        // Cambiar el estado de la cita médica a 0 (disponible)
        ps = conn.prepareStatement("UPDATE citas_medica SET estado = 0 WHERE id = ?");
        ps.setString(1, citaId);
        ps.executeUpdate();

        // Redirigir al cliente
        response.sendRedirect("VerCitasAsignadas.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (ps != null) try { ps.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
