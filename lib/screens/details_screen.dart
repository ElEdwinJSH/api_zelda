import 'package:api_zelda/services/auth_services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:api_zelda/models/zelda_games.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {//-------------------------------------------------

  const DetailsScreen({super.key,});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}//-------------------------------------------------

class _DetailsScreenState extends State<DetailsScreen> {//-------------------------------------------------
  AudioPlayer player = AudioPlayer();
  
   bool isFavorite = false;

  bool isTextVisible = true;
  void toggleTextVisibility() {
    setState(() {
      isTextVisible = !isTextVisible;
    });
  }

  @override
  void dispose() {
    fadeMusica(); // Llamas a la función que detiene la música al cerrar la pantalla
    super.dispose();
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
  Widget build(BuildContext context) {//-------------------------------------------------
  
    final size = MediaQuery.of(context).size;
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
final Games game = args['game'];
final String userEmail = args['userEmail'];

    playm('${game.id}.mp3');

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
          backgroundColor: Colors.green.shade800,
          title: Text(
            (game.id == '5f6ce9d805615a85623ec2ce')
                ? 'The Legend of Zelda Tears of the Kingdom'
                : game.name,
                
            style: TextStyle(fontSize: 15),
          ),actions: [
          IconButton(
            icon: Icon(
              isFavorite==true ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
              size: 30,
            ),
            onPressed: () {
              toggleFavorite();
            },
          ),
        ],
          ),
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


    
  }//-------------------------------------------------
void toggleFavorite() {
setState(() {
  isFavorite = !isFavorite;
});


   final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
final Games game = args['game'];
final String userEmail = args['userEmail'];
  
 // isFavorite = !isFavorite;
 String juegoId = game.id;

    final authService = Provider.of<AuthService>(context, listen: false);
print(userEmail);
print(juegoId);
    // Llama a la función correspondiente en tu servicio
    if (isFavorite==true) {
      print('entra');
      authService.agregarJuegoFavorito(userEmail,juegoId);
    } else {
      //authService.quitarJuegoFavorito(juegoId);
    }
  
}

  Future<void> playm(String path) async {
    await player.play(AssetSource(path));
  }
}//-------------------------------------------------










class _Texto extends StatelessWidget {//-------------------------------------------------
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
              (games.id == '5f6ce9d805615a85623ec2ce')
                  ? 'Tears of the Kingdom retains the open-world action-adventure gameplay of Breath of the Wild (2017). As Link, players explore Hyrule and two new areas; the sky, which is littered with numerous floating islands, and the Depths, a vast underground area beneath Hyrule, to find weapons and resources and complete quests.'
                  : games.description,
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
}//-------------------------------------------------

