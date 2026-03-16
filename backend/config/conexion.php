<?php
header('Content-Type: application/json');

$host = "127.0.0.1";
$usuario = "root";
$password = "";
$baseDatos = "app_inventario";
$puerto = 3307;

$conexion = new mysqli($host, $usuario, $password, $baseDatos, $puerto);

if ($conexion->connect_error) {
    echo json_encode([
        "success" => false,
        "message" => "Error de conexión a la base de datos"
    ]);
    exit;
}

$conexion->set_charset("utf8");
?>