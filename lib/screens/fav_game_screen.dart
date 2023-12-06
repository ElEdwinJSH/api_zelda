import 'package:api_zelda/models/zelda_games.dart';
import 'package:api_zelda/services/auth_services.dart';
import 'package:flutter/material.dart';

class FavGame extends StatefulWidget {
  const FavGame({
    super.key,
  });

  @override
  State<FavGame> createState() => _FavGameState();
}

class _FavGameState extends State<FavGame> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<Games> games = args['game'];
    final String userEmail = args['userEmail'];

    print(userEmail);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text('Juegos Favoritos'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: authService.obtenerJuegosFavoritos(userEmail),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras se obtienen los datos
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Muestra un mensaje de error si ocurre un error
            return Center(
              child:
                  Text('Error al obtener juegos favoritos: ${snapshot.error}'),
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
              itemBuilder: (_, index) {
                final game = games.firstWhere(
                    (game) => game.id == juegosFavoritos[index]['juegoId'],);//aqui checa si el gameid y el juegoid de ese index son iguales

                //  final game = games[index];
                if (game != null) {
                  return ListTile(
                    title: Text(game.name ?? ''),
                    // leading: Image.network(game.imagenUrl ?? ''),
                  );
                } else {
                  // Puedes devolver un widget vacío o null si no hay coincidencia
                  return SizedBox.shrink();
                }
              },
            );
          }
        },
      ),
    );
  }
}
