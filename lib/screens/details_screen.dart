import 'package:flutter/material.dart';
import 'package:api_zelda/models/zelda_games.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Games game = ModalRoute.of(context)?.settings.arguments as Games;
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 0.5,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(game.gameImage),
                  ),
                )),
            Container(
                alignment: Alignment.center,
                child: _Texto(
                  games: game,
                )
                /*const Text(
                  'Show text here',
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0),
                )*/
                ),
          ],
        ),
      ),
    );
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
          color: Colors.grey.withOpacity(0.7)
          // Bordes redondeados
          ),
      child: Text(
        games.description,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
