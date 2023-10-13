import 'package:api_zelda/widgets/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioPlayer _audioPlayer = AudioPlayer();

    String soundFilePath = "flechas_sonido.wav";

    Future<void> _playSound() async {
      await _audioPlayer.play(soundFilePath as Source, volume: 100);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('inicio'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _playSound();
              // Coloca aquí el código que quieras ejecutar cuando se presione el botón.
            },
          ),
        ],
      ),
      body: Column(children: [CardSwiper()]),
    );
  }
}
