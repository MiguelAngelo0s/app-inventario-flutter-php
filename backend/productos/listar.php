<?php
require_once("../config/conexion.php");

$sql = "SELECT id, nombre, descripcion, precio, stock, usuario_id FROM productos ORDER BY id DESC";
$resultado = $conexion->query($sql);

$productos = [];

while ($fila = $resultado->fetch_assoc()) {
    $productos[] = $fila;
}

echo json_encode([
    "success" => true,
    "productos" => $productos
]);
?>