import 'package:api_zelda/services/auth_services.dart';
import 'package:flutter/material.dart';

class FavGame extends StatelessWidget {
   FavGame({super.key});
final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green.shade700,
        title: const Text('Juegos Favoritos'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: authService.obtenerJuegosFavoritos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras se obtienen los datos
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Muestra un mensaje de error si ocurre un error
            return Center(
              child: Text('Error al obtener juegos favoritos: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Muestra un mensaje si no hay juegos favoritos
            return const Center(
              child: Text('No tienes juegos favoritos'),
            );
          } else {
            // Muestra la lista de juegos favoritos
            List<Map<String, dynamic>> juegosFavoritos = snapshot.data!;
            return ListView.builder(
              itemCount: juegosFavoritos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(juegosFavoritos[index]['nombre'] ?? ''),
                  leading: Image.network(juegosFavoritos[index]['imagenUrl'] ?? ''),
                );
              },
            );
          }
        },
      ),
    );
  }
}