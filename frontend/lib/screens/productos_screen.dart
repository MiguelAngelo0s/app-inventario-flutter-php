import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../models/usuario.dart';
import '../services/api_service.dart';
import 'producto_form_screen.dart';

class ProductosScreen extends StatefulWidget {
  final Usuario usuario;

  const ProductosScreen({super.key, required this.usuario});

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  List<Producto> productos = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    setState(() {
      cargando = true;
    });

    productos = await ApiService.obtenerProductos();

    setState(() {
      cargando = false;
    });
  }

  Future<void> eliminarProducto(int id) async {
    final respuesta = await ApiService.eliminarProducto(id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(respuesta['message'])),
    );

    if (respuesta['success'] == true) {
      cargarProductos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductoFormScreen(usuario: widget.usuario),
            ),
          );
          cargarProductos();
        },
        child: const Icon(Icons.add),
      ),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return ListTile(
                  title: Text(producto.nombre),
                  subtitle: Text(
                    'Precio: ${producto.precio} - Stock: ${producto.stock}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductoFormScreen(
                                usuario: widget.usuario,
                                producto: producto,
                              ),
                            ),
                          );
                          cargarProductos();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => eliminarProducto(producto.id),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}