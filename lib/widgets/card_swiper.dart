import 'package:api_zelda/models/zelda_games.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:soundpool/soundpool.dart';

class CardSwiper extends StatefulWidget {//---------------------------------
  final List<Games> games;
   final String userEmail;
  const CardSwiper({super.key, required this.games, required this.userEmail});

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}//---------------------------------------------------------------------

class _CardSwiperState extends State<CardSwiper> {//---------------------------------------
  @override
  void initState() {
    super.initState();
    playm('Menu.mp3');
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

  AudioPlayer player = AudioPlayer();
  bool isMusicPlaying = true;

  @override
  Widget build(BuildContext context) {//---------------------------------------------------------

    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(children: [
        const SizedBox(height: 16.0),
       
        const SizedBox(height: 16.0),
        Container(
          child: SizedBox(
            width: size.width * 0.95,
            height: size.height * 0.78,
            child: Swiper(
              itemBuilder: (_, int index) {
                final game = widget.games[index];

                // count = games.length + 1;
                return GestureDetector(
                  onTap: () {
                    //pausa la musica al tocar la tarjeta
                  print(widget.userEmail);
                      fadeMusica(); //si hay musica, se va a detener
                  
                    Navigator.pushNamed(context, 'details', arguments: {'game': game, 'userEmail': widget.userEmail})
                        .then((_) {
                      // el codigo corre cuando details cierra.
                      playm('Menu.mp3');
                      player.setVolume(1.0);
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
//                      placeholder: AssetImage(game.gameImage),
                      image: AssetImage(game.gameImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ); //saber que se hace con el tactil con el dedo
              },
            
              itemCount: widget.games.length,
              itemHeight: size.height * 0.4,
              itemWidth: size.width * 0.5,
              control: const SwiperControl(
                iconNext: Icons.arrow_forward,
                iconPrevious: Icons.arrow_back,
                color: Colors.blue,
                size: 50,
                padding: EdgeInsets.all(5),
              ),
            ),
          ),
        ),
      ]),
    );
  }//--------------------------------------------------------------------------


  Future<void> playm(String path) async {
    await player.play(AssetSource(path));
  }
}//-----------------------------------------------------------------------------

