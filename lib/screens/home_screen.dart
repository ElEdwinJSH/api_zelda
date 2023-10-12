import 'package:api_zelda/widgets/card_swiper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('inicio'),
      ),
      body: Column(children: [CardSwiper()]),
    );
  }
}
