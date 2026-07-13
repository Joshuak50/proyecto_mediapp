import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mediapp/Pages/ListMedicamentos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages/Home.dart';
import '../Pages/Login.dart';
import '../Utilerias/Ambiente.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? nombreUsuario;
  String? fotoPerfil;

  Future<int?> obtenerIdUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id_usuario'); // Recupera el id_usuario guardado
  }

  // Corregir el nombre de la función y eliminar la llamada recursiva innecesaria
  Future<void> obtenerDatosUser() async {
    final idUsuario = await obtenerIdUsuario();
    if (idUsuario != null) {
      final response = await http.get(
        Uri.parse('${Ambiente.urlServe}/api/user/$idUsuario'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Decodifica la respuesta JSON
        String email = data['email']; // Extrae el email de la respuesta

        // Ahora puedes utilizar el email en otra función
        obtenerDatosUsuario(email); // Llama a la función donde necesites el email
      } else {
        print('Error al obtener datos del user: ${response.statusCode}');
      }
    }
  }

  // Corregir la forma en que usas las variables para actualizar el estado
  Future<void> obtenerDatosUsuario(String email) async {
    try {
      if (email.isNotEmpty) {
        final response = await http.get(
          Uri.parse('${Ambiente.urlServe}/api/usuario/$email'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body); // Decodifica la respuesta JSON
          setState(() {
            nombreUsuario = data['nombre'];
            fotoPerfil = data['imagen'];
          });
        } else {
          print('Error al obtener datos del usuario: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerDatosUser(); // Llama a la función al inicio
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[700],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: fotoPerfil != null && fotoPerfil!.isNotEmpty
                      ? NetworkImage(fotoPerfil!)
                      : null, // Muestra la imagen del perfil si está disponible
                ),
                const SizedBox(height: 10),
                Text(
                  nombreUsuario ?? 'Cargando...',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Inicio'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home())
              );
            },
          ),
          ListTile(
            title: const Text('Medicamentos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Listmedicamentos()),
              );
            },
          ),
          ListTile(
            title: const Text('Cerrar sesión'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // Limpia las preferencias almacenadas.

              // Redirige al usuario a la pantalla de inicio de sesión
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()), // Redirige a la vista de login
                    (route) => true, // Elimina todas las rutas anteriores
              );
            },
          ),
        ],
      ),
    );
  }
}
