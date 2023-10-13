import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:soundpool/soundpool.dart';

class CardSwiper extends StatefulWidget {
  const CardSwiper({super.key});

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  // String soundFilePath = "assets/flechas_sonido.wav";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: SizedBox(
          width: size.width * 0.95,
          height: size.height * 0.83,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network('http://via.placeholder.com/350x150',
                  fit: BoxFit.fill);
            },
            onIndexChanged: (index) {
              _playSound();
            },
            itemCount: 5,
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
    );
  }

  Future<void> _playSound() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);
    int soundId = await rootBundle
        .load("assets/flechas_sonido.wav")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }
}
