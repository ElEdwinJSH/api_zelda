import 'package:api_zelda/screens/fav_game_screen.dart';
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
  late String userEmail;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the email from the arguments
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userEmail = args['email'];
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final gamesProvider = Provider.of<GamesProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green.shade700,
          title: const Center(
            child: Text('Zelda API'),
          ),
            leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),),
      endDrawer: DrawerN(),
      body: Column(children: [CardSwiper(games: gamesProvider.onDisplayGames, userEmail: userEmail)]),
      backgroundColor: Colors.grey.shade900,
    );
  }

  Future<void> playm(String path) async {
    await player.play(AssetSource(path));
  }
}

class DrawerN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
   final userEmail = args['email'];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menú'),
          ),
          ListTile(
            title: Text('Juegos Favoritos'),
            onTap: () {
              print(userEmail);
               Navigator.pushNamed(context, 'favoritos', arguments: { 'userEmail': userEmail});
            },
          ),
        
          // Agregar más opciones según sea necesario
        ],
      ),
    );
  }
}