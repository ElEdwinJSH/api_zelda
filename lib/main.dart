import 'package:api_zelda/providers/games_provider.dart';
import 'package:api_zelda/screens/check_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:api_zelda/screens/screens.dart';
import 'package:provider/provider.dart';

import 'services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override //ANTES S ECORRIA MYAPP PRIMERO, AHORA ES EL APPSTATE QUE TIENE L PROVIDER, MANEJADOR DE ESTADO.
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //AVISA QUE HAY CAMBI ASI QUE SE ACTUALIZA,
          create: (_) => GamesProvider(),
          lazy:
              false, //normalmetne es perezoso pero aqui hacemos que no sea asi e inicie al inicar la aplicacion
        ),
         ChangeNotifierProvider(
          //AVISA QUE HAY CAMBI ASI QUE SE ACTUALIZA,
          create: (_) => AuthService(),
          lazy:
              false, //normalmetne es perezoso pero aqui hacemos que no sea asi e inicie al inicar la aplicacion
        )
      ],
      child: const MyApp(),
    ); //pide varios providers, depende si son varias peticiones http
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api Zelda',
      initialRoute: 'login',
      routes: {
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen(),
        'login': (_) => LoginScreen(),
        'register': (_) => RegistroScreen(),
        'checking': (_) => CheckAuthScreen(),
      },
    );
  }
}
