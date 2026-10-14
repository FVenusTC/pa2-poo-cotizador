<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. Leer los datos del formulario
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String producto = request.getParameter("producto");
    String precioTxt = request.getParameter("precio");
    String cantidadTxt = request.getParameter("cantidad");
    String descuentoTxt = request.getParameter("descuento");

    // Si algo llega null (por ejemplo, si abren resultado.jsp directo), lo dejamos vacío
    if (nombre == null) nombre = "";
    if (correo == null) correo = "";
    if (producto == null) producto = "";
    if (precioTxt == null) precioTxt = "";
    if (cantidadTxt == null) cantidadTxt = "";
    if (descuentoTxt == null) descuentoTxt = "";

    // 2. Quitar espacios de los extremos
    nombre = nombre.trim();
    correo = correo.trim();
    producto = producto.trim();
    precioTxt = precioTxt.trim();
    cantidadTxt = cantidadTxt.trim();
    descuentoTxt = descuentoTxt.trim();

    String errores = "";

    // 3. Validaciones de texto (String)
    if (nombre.length() < 3) {
        errores += "<li>El nombre debe tener al menos 3 caracteres.</li>";
    }

    int posArroba = correo.indexOf("@");
    if (posArroba <= 0 || !correo.substring(posArroba).contains(".") || correo.contains(" ")) {
        errores += "<li>El correo no es válido (ejemplo: nombre@correo.com).</li>";
    }

    if (producto.isEmpty()) {
        errores += "<li>Debes escribir el nombre del producto.</li>";
    }

    // 4. Convertir los números y validar sus rangos
    double precio = 0;
    try {
        precio = Double.parseDouble(precioTxt.replace(",", "."));
        if (precio <= 0) {
            errores += "<li>El precio debe ser mayor que 0.</li>";
        }
    } catch (NumberFormatException e) {
        errores += "<li>El precio debe ser un número (ejemplo: 50 o 49.90).</li>";
    }

    int cantidad = 0;
    try {
        cantidad = Integer.parseInt(cantidadTxt);
        if (cantidad < 1) {
            errores += "<li>La cantidad debe ser al menos 1.</li>";
        }
    } catch (NumberFormatException e) {
        errores += "<li>La cantidad debe ser un número entero (ejemplo: 3).</li>";
    }

    double descuento = 0;
    if (!descuentoTxt.isEmpty()) {
        try {
            descuento = Double.parseDouble(descuentoTxt.replace(",", "."));
            if (descuento < 0 || descuento > 50) {
                errores += "<li>El descuento debe estar entre 0 y 50.</li>";
            }
        } catch (NumberFormatException e) {
            errores += "<li>El descuento debe ser un número (ejemplo: 10).</li>";
        }
    }

    // 5. Cálculos (Math) y transformaciones (String), solo si no hay errores
    double subtotal = 0;
    double montoDescuento = 0;
    double baseImponible = 0;
    double igv = 0;
    double total = 0;
    double totalAPagar = 0;
    String nombreMayus = "";
    String productoFormato = "";
    String codigo = "";

    if (errores.isEmpty()) {
        double factor = Math.pow(10, 2); // 100, para redondear a 2 decimales

        subtotal = Math.round(precio * cantidad * factor) / factor;
        montoDescuento = Math.round(subtotal * descuento / 100 * factor) / factor;
        baseImponible = Math.max(subtotal - montoDescuento, 0);
        igv = Math.round(baseImponible * 0.18 * factor) / factor;
        total = Math.round((baseImponible + igv) * factor) / factor;
        totalAPagar = Math.ceil(total);

        nombreMayus = nombre.toUpperCase();
        productoFormato = producto.substring(0, 1).toUpperCase() + producto.substring(1).toLowerCase();
        codigo = nombre.substring(0, 3).toUpperCase() + "-" + producto.length() + "-" + cantidad;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado</title>
</head>
<style>
    body { font-family: Arial, sans-serif; max-width: 500px; margin: 40px auto; }
    input { width: 100%; padding: 6px; box-sizing: border-box; }
    button { padding: 8px 16px; }
    table { border-collapse: collapse; }
</style>
<body>
<% if (!errores.isEmpty()) { %>

    <h1>Hay datos por corregir</h1>
    <ul>
        <%= errores %>
    </ul>
    <p><a href="index.jsp">Volver al formulario</a></p>

<% } else { %>

    <h1>Resultado de la cotización</h1>
    <p>Código de cotización: <b><%= codigo %></b></p>
    <p>Cliente: <%= nombreMayus %></p>
    <p>Correo: <%= correo %></p>
    <p>Producto: <%= productoFormato %></p>
    <p>Precio unitario: S/ <%= precio %></p>
    <p>Cantidad: <%= cantidad %></p>

    <table border="1" cellpadding="6">
        <tr><td>Subtotal</td><td>S/ <%= subtotal %></td></tr>
        <tr><td>Descuento (<%= descuento %>%)</td><td>S/ <%= montoDescuento %></td></tr>
        <tr><td>Base imponible</td><td>S/ <%= baseImponible %></td></tr>
        <tr><td>IGV (18%)</td><td>S/ <%= igv %></td></tr>
        <tr><td>Total</td><td>S/ <%= total %></td></tr>
        <tr><td><b>Total a pagarㅤㅤㅤㅤㅤㅤㅤ</b></td><td><b>S/ <%= totalAPagar %></b></td></tr>
    </table>

    <p><a href="index.jsp">Hacer otra cotización</a></p>

<% } %>
</body>
</html>