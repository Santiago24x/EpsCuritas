<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px; /* Tamaño máximo del contenedor */
            margin: auto; /* Centrando el contenedor */
            padding: 20px; /* Espaciado interno */
            border-radius: 10px; /* Bordes redondeados */
            background-color: white; /* Fondo blanco para el formulario */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Sombra sutil */
        }
        .logo {
            display: block;
            margin: 0 auto 20px; /* Centrar y agregar margen inferior */
            width: 100px; /* Ajusta el tamaño según necesites */
        }
    </style>
</head>
<body>
    <div class="login-container mt-5">
        <div class="text-center">
            <img src="./Logo.png" alt="Logo de EPS Curitas" class="logo">
        </div>

        <form action="LoginHandler.jsp" method="post">
            <div class="mb-3">
                <label for="correo" class="form-label">Correo</label>
                <input type="email" class="form-control" id="correo" name="correo" required>
            </div>
            <div class="mb-3">
                <label for="contrasena" class="form-label">Contraseña</label>
                <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                <!-- Opción para mostrar/ocultar contraseña -->
                <input type="checkbox" id="showPassword"> Mostrar contraseña
            </div>
            <button type="submit" class="btn btn-primary w-100">Iniciar Sesión</button>
        </form>
        <p class="mt-3 text-center">¿No tienes una cuenta? <a href="Register.jsp">Regístrate</a></p>
    </div>

    <script>
        // Script para mostrar/ocultar la contraseña
        document.getElementById('showPassword').addEventListener('change', function() {
            const passwordField = document.getElementById('contrasena');
            passwordField.type = this.checked ? 'text' : 'password';
        });
    </script>
</body>
</html>
