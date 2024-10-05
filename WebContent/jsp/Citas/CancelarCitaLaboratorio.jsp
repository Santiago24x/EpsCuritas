<%@ page import="java.sql.*" %>
<%
    // Obtener el ID del laboratorio a cancelar
    String laboratorioId = request.getParameter("laboratorioId");
    Integer userId = (Integer) request.getSession().getAttribute("userId");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Establecer conexión a la base de datos remota
        conn = DriverManager.getConnection("jdbc:mysql://sql10.freemysqlhosting.net:3306/sql10735566", "sql10735566", "u9xMt5EqYQ");

        // Eliminar la relación entre el cliente y la cita de laboratorio
        ps = conn.prepareStatement("DELETE FROM cliente_laboratorio WHERE cliente_id = ? AND laboratorio_id = ?");
        ps.setInt(1, userId);
        ps.setString(2, laboratorioId);
        ps.executeUpdate();
        ps.close();

        // Cambiar el estado de la cita de laboratorio a 0 (disponible)
        ps = conn.prepareStatement("UPDATE laboratorios SET estado = 0 WHERE id = ?");
        ps.setString(1, laboratorioId);
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
