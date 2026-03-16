<?php
header('Content-Type: application/json');

$host = "localhost";
$usuario = "root";
$password = "";
$baseDatos = "app_inventario";

$conexion = new mysqli($host, $usuario, $password, $baseDatos);

if ($conexion->connect_error) {
    echo json_encode([
        "success" => false,
        "message" => "Error de conexión a la base de datos"
    ]);
    exit;
}

$conexion->set_charset("utf8");
?>