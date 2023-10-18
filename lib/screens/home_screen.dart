import 'package:api_zelda/widgets/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:api_zelda/providers/games_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gamesProvider = Provider.of<GamesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('inicio'),
      ),
      body: Column(children: [CardSwiper(games: gamesProvider.onDisplayGames)]),
    );
  }
}
