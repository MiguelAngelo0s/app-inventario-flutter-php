<?php
require_once("../config/conexion.php");

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Método no permitido"
    ]);
    exit;
}

$nombre = $_POST['nombre'] ?? '';
$descripcion = $_POST['descripcion'] ?? '';
$precio = $_POST['precio'] ?? '';
$stock = $_POST['stock'] ?? '';
$usuario_id = $_POST['usuario_id'] ?? '';

if ($nombre == '' || $precio == '' || $stock == '' || $usuario_id == '') {
    echo json_encode([
        "success" => false,
        "message" => "Faltan datos obligatorios"
    ]);
    exit;
}

$sql = "INSERT INTO productos (nombre, descripcion, precio, stock, usuario_id)
        VALUES (?, ?, ?, ?, ?)";

$stmt = $conexion->prepare($sql);
$stmt->bind_param("ssdii", $nombre, $descripcion, $precio, $stock, $usuario_id);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Producto creado correctamente"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Error al crear producto"
    ]);
}