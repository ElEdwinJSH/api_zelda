import 'package:api_zelda/models/zelda_games.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:soundpool/soundpool.dart';

class CardSwiper extends StatelessWidget {
  final List<Games> games;
  const CardSwiper({super.key, required this.games});

  // String soundFilePath = "assets/flechas_sonido.wav";
  @override
  Widget build(BuildContext context) {
    /*   int count = 0;
    int lastPlayedIndex = -1;
    int currentIndex = 0;
    int indexChangeCount = 0;
*/
    final size = MediaQuery.of(context).size;
    //   final Games gamess = ModalRoute.of(context)?.settings.arguments as Games;
    return Center(
      child: Column(children: [
        SizedBox(height: 16.0),
        //_Titulo(game: games[context]),
        /* _Titulo(
          game: games.ge,
        ),*/
        SizedBox(height: 16.0),
        Container(
          // margin: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            width: size.width * 0.95,
            height: size.height * 0.78,
            child: Swiper(
              itemBuilder: (_, int index) {
                final game = games[index];

                // count = games.length + 1;
                return GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, 'details', arguments: game),
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
              /* onIndexChanged: (index) {
                if (index != lastPlayedIndex) {
                  // Verifica si el índice ha cambiado
                  _playSound();
                  lastPlayedIndex =
                      index; // Actualiza el último índice reproducido
                }
              },*/ //ide
              /*  onIndexChanged: (index) {
                currentIndex = index; // Actualiza el índice actual
                print("Current Index: $currentIndex");
                // Verifica si se han realizado 15 cambios de índice y reproduce el sonido
                if (indexChangeCount < 25) {
                  indexChangeCount++;
                } else {
                  print("Current change: $indexChangeCount");
                  indexChangeCount++;
                  _playSound(indexChangeCount);
                }
              },*/
              itemCount: games.length,
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
  }

  Future<void> _playSound(int indexChangeCount) async {
    // Puedes acceder a indexChangeCount aquí y usarlo según sea necesario.
    if (indexChangeCount > 9) {
      Soundpool pool = Soundpool(streamType: StreamType.notification);
      int soundId = await rootBundle
          .load("assets/flechas_sonido.wav")
          .then((ByteData soundData) {
        return pool.load(soundData);
      });
      pool.play(soundId);
      // Realiza acciones específicas si indexChangeCount es menor que 9.
    } else {
      // Realiza acciones específicas si indexChangeCount es 9 o más.
    }
  }
}

class _Titulo extends StatelessWidget {
  final Games game;
  const _Titulo({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Text(
      game.name, overflow: TextOverflow.visible, //------------------
      style: TextStyle(fontSize: 25),
    );
  }
}
