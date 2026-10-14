<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cotizador</title>
</head>
<style>
    body { font-family: Arial, sans-serif; max-width: 500px; margin: 40px auto; }
    input { width: 100%; padding: 6px; box-sizing: border-box; }
    button { padding: 8px 16px; }
    table { border-collapse: collapse; }
</style>
<body>
    <h1>Cotizador de productos</h1>

    <form action="resultado.jsp" method="post">

        <p>
            <label for="nombre">Nombre del cliente:</label><br>
            <input type="text" id="nombre" name="nombre">
        </p>

        <p>
            <label for="correo">Correo electronico:</label><br>
            <input type="text" id="correo" name="correo">
        </p>

        <p>
            <label for="producto">Producto:</label><br>
            <input type="text" id="producto" name="producto">
        </p>

        <p>
            <label for="precio">Precio unitario (S/):</label><br>
            <input type="text" id="precio" name="precio">
        </p>

        <p>
            <label for="cantidad">Cantidad:</label><br>
            <input type="text" id="cantidad" name="cantidad">
        </p>

        <p>
            <label for="descuento">Descuento (%), de 0 a 50:</label><br>
            <input type="text" id="descuento" name="descuento" value="0">
        </p>

        <button type="submit">Cotizar</button>

    </form>
</body>
</html>