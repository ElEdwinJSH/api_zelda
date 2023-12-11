import 'package:api_zelda/models/zelda_games.dart';
import 'package:api_zelda/providers/games_provider.dart';
import 'package:api_zelda/services/auth_services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavGame extends StatefulWidget {
  const FavGame({
    super.key,
  });

  @override
  State<FavGame> createState() => _FavGameState();
}

class _FavGameState extends State<FavGame> {
  final AuthService authService = AuthService();
  AudioPlayer player = AudioPlayer();

  Future<void> playm(String path) async {
    await player.play(AssetSource(path));
  }

  @override
  void initState() {
    super.initState();
    player.setReleaseMode(ReleaseMode.loop);
    playm('JuegosFavoritos.mp3');
  }

  void fadeMusica() async {
    const fadeDuration = Duration(
        milliseconds:
            500); // Puedes ajustar la duración del fade out según tus preferencias
    const fadeSteps = 10;
    const initialVolume = 1.0;

    for (int i = 0; i < fadeSteps; i++) {
      double volume = initialVolume - (i / fadeSteps);
      await player.setVolume(volume);
      await Future.delayed(fadeDuration ~/ fadeSteps);
    }

    player.stop(); // Detiene la reproducción después del fade out
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<Games> games = args['game'];
    final String userEmail = args['userEmail'];
    print('fav');
    print(userEmail);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 194, 194),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 82, 31),
        title: const Text('Juegos Favoritos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //  authService.logout();
            fadeMusica();
            Navigator.pushReplacementNamed(context, 'home',
                arguments: {'email': userEmail});
          },
        ),
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
                  (game) => game.id == juegosFavoritos[index]['juegoId'],
                ); //aqui checa si el gameid y el juegoid de ese index son iguales

                //  final game = games[index];
                return GestureDetector(
                  onTap: () {
                    print('ontap');
                    print(userEmail);
                    fadeMusica();
                    // Navegar a otra pantalla cuando se toca el elemento
                    Navigator.pushNamed(context, 'details',
                            arguments: {'game': game, 'userEmail': userEmail})
                        .then((_) {
                      // el codigo corre cuando details cierra.
                      playm('JuegosFavoritos.mp3');
                      player.setVolume(1.0);
                      setState(() {});
                    });
                  },
                  child: ListTile(
                    title: Text(
                      (game.id == '5f6ce9d805615a85623ec2ce')
                          ? 'The Legend of Zelda Tears of the Kingdom'
                          : game.name,
                    ),
                    leading: Image.asset(game.gameImage ?? ''),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
