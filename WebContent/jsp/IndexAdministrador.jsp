<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Obtener la sesión y verificar la autenticación del usuario
    Integer userId = (Integer) request.getSession().getAttribute("userId");

    // Verificar si el usuario está autenticado
    if (userId == null) {
        response.sendRedirect("../Logins/Login.jsp"); // Redirigir si no hay sesión
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listados</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .card {
            text-align: center;
            transition: transform 0.2s;
            cursor: pointer;
        }
        .card:hover {
            transform: scale(1.05);
        }
        .icon {
            font-size: 4rem;
            color: #007bff;
        }
        .card-title {
            margin-top: 10px;
        }
        .text-blue {
            color: #007bff;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img src="../Img/Logo.png" alt="Logo" width="200" height="100" class="d-inline-block align-text-top">
            </a>
            <div class="d-flex">
                <a href="./Logins/logout.jsp" class="btn btn-outline-primary me-4" title="Cerrar sesión">
                    <i class="bi bi-box-arrow-right"></i>
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h1 class="mb-4 text-center">Bienvenido, <span class="text-blue">Administrador</span></h1>
        <div class="row">

            <!-- Tarjeta para Listado de Laboratorios -->
            <div class="col-md-3">
                <a href="./Laboratorios/ListadoLaboratorios.jsp" class="text-decoration-none">
                    <div class="card shadow-sm p-3">
                        <i class="bi bi-file-earmark-medical icon"></i>
                        <h5 class="card-title">Registro Laboratorios</h5>
                    </div>
                </a>
            </div>

            <!-- Tarjeta para Listado de Médicos -->
            <div class="col-md-3">
                <a href="./Medicos/ListadoMedicos.jsp" class="text-decoration-none">
                    <div class="card shadow-sm p-3">
                        <i class="bi bi-person-lines-fill icon"></i>
                        <h5 class="card-title">Registro Médicos</h5>
                    </div>
                </a>
            </div>

            <!-- Tarjeta para Listado de Citas -->
            <div class="col-md-3">
                <a href="./Citas/ListadoCitas.jsp" class="text-decoration-none">
                    <div class="card shadow-sm p-3">
                        <i class="bi bi-calendar2-check icon"></i>
                        <h5 class="card-title">Registro de Citas</h5>
                    </div>
                </a>
            </div>

            <!-- Tarjeta para Listado de Clientes -->
            <div class="col-md-3">
                <a href="./Clientes/ListadoClientes.jsp" class="text-decoration-none">
                    <div class="card shadow-sm p-3">
                        <i class="bi bi-people-fill icon"></i>
                        <h5 class="card-title">Registro de Clientes</h5>
                    </div>
                </a>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
