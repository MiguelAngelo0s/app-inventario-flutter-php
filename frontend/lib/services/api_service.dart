import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/producto.dart';
import '../models/usuario.dart';

class ApiService {

  static const String baseUrl = 'http://localhost/appInventario/backend';

  static Future<Map<String, dynamic>> registrarUsuario({
    required String nombre,
    required String correo,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/registro.php'),
      body: {
        'nombre': nombre,
        'correo': correo,
        'password': password,
      },
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> login({
    required String correo,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login.php'),
      body: {
        'correo': correo,
        'password': password,
      },
    );
    return jsonDecode(response.body);
  }

  static Future<List<Producto>> obtenerProductos() async {
    final response = await http.get(
      Uri.parse('$baseUrl/productos/listar.php'),
    );
    final data = jsonDecode(response.body);

    if (data['success'] == true) {
      return (data['productos'] as List)
          .map((item) => Producto.fromJson(item))
          .toList();
    }
    return [];
  }

  static Future<Map<String, dynamic>> crearProducto({
    required String nombre,
    required String descripcion,
    required String precio,
    required String stock,
    required int usuarioId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/productos/crear.php'),
      body: {
        'nombre': nombre,
        'descripcion': descripcion,
        'precio': precio,
        'stock': stock,
        'usuario_id': usuarioId.toString(),
      },
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> actualizarProducto({
    required int id,
    required String nombre,
    required String descripcion,
    required String precio,
    required String stock,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/productos/actualizar.php'),
      body: {
        'id': id.toString(),
        'nombre': nombre,
        'descripcion': descripcion,
        'precio': precio,
        'stock': stock,
      },
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> eliminarProducto(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/productos/eliminar.php'),
      body: {
        'id': id.toString(),
      },
    );
    return jsonDecode(response.body);
  }

  static Usuario convertirUsuario(Map<String, dynamic> json) {
    return Usuario.fromJson(json);
  }
}