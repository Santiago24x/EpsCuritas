<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Invalidar la sesión
    session.invalidate();

    // Redirigir a la página de inicio de sesión
    response.sendRedirect("Login.jsp");
%>
