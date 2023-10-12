import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatefulWidget {
  const CardSwiper({super.key});

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: SizedBox(
          width: size.width * 0.95,
          height: size.height * 0.83,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return new Image.network('http://via.placeholder.com/350x150',
                  fit: BoxFit.fill);
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
}
