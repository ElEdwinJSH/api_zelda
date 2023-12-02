import 'package:api_zelda/widgets/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:api_zelda/providers/games_provider.dart';
import 'package:provider/provider.dart';
//import 'package:soundpool/soundpool.dart';
//import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

import '../services/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioPlayer player = AudioPlayer();


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final gamesProvider = Provider.of<GamesProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green.shade700,
          title: Center(
            child: Text('Zelda API'),
          ),
            leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),),
      body: Column(children: [CardSwiper(games: gamesProvider.onDisplayGames)]),
      backgroundColor: Colors.grey.shade900,
    );
  }

  Future<void> playm(String path) async {
    await player.play(AssetSource(path));
  }
}
