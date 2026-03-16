<?php
require_once("../config/conexion.php");

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Método no permitido"
    ]);
    exit;
}

$nombre = trim($_POST['nombre'] ?? '');
$correo = trim($_POST['correo'] ?? '');
$password = trim($_POST['password'] ?? '');

if ($nombre === '' || $correo === '' || $password === '') {
    echo json_encode([
        "success" => false,
        "message" => "Todos los campos son obligatorios"
    ]);
    exit;
}

$sqlVerificar = "SELECT id FROM usuarios WHERE correo = ?";
$stmtVerificar = $conexion->prepare($sqlVerificar);
$stmtVerificar->bind_param("s", $correo);
$stmtVerificar->execute();
$resultadoVerificar = $stmtVerificar->get_result();

if ($resultadoVerificar->num_rows > 0) {
    echo json_encode([
        "success" => false,
        "message" => "El correo ya está registrado"
    ]);
    exit;
}

$passwordEncriptado = password_hash($password, PASSWORD_DEFAULT);

$sqlInsertar = "INSERT INTO usuarios (nombre, correo, password) VALUES (?, ?, ?)";
$stmtInsertar = $conexion->prepare($sqlInsertar);
$stmtInsertar->bind_param("sss", $nombre, $correo, $passwordEncriptado);

if ($stmtInsertar->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Usuario registrado correctamente"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "No se pudo registrar el usuario"
    ]);
}
?>