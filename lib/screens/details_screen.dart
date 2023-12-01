import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:api_zelda/models/zelda_games.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  AudioPlayer player = AudioPlayer();

  bool isTextVisible = true;
  void toggleTextVisibility() {
    setState(() {
      isTextVisible = !isTextVisible;
    });
  }

  @override
  void dispose() {
    // Detener la reproducción cuando el widget se dispose (se cierre)
    player.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Games game = ModalRoute.of(context)?.settings.arguments as Games;



     playm(game.id+'.mp3');


    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
          backgroundColor: Colors.green.shade800,
          title: Text(
            game.name,
            style: TextStyle(fontSize: 15),
          )),
      body: Center(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              
              onTap: () {
                if (!isTextVisible) {
                  toggleTextVisibility();
                }
              },
              
              
              child: Container(
                width: size.width,
                height: size.height,
                alignment: Alignment.center,
                child: Opacity(
                  opacity: isTextVisible ? 0.5 : 1.0,
                  child: Image(
                    image: AssetImage(game.gameImage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            if (isTextVisible)
              GestureDetector(
                onTap: toggleTextVisibility, // Toggle the text visibility
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _Texto(
                          games: game,
                        ),
                      ]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> playm(String path) async {
    await player.play(AssetSource(path));
  }
}

class _Texto extends StatelessWidget {
  final Games games;

  const _Texto({super.key, required this.games});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Espaciado interno del marco
      margin: const EdgeInsets.all(16.0), // Margen alrededor del marco
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Color del borde
            width: 2.0, // Ancho del borde
          ),
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey.withOpacity(0.85)
          // Bordes redondeados
          ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Descripción:',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              games.description,
              style: const TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10),
            Text(
              'Presiona para ocultar',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.red.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Musica extends StatelessWidget {
  final Games game;
  const _Musica({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Text(game.gameMusic);
  }
}

