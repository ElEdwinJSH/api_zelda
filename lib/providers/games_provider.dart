import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //llamar libreria con http

import 'package:api_zelda/models/zelda_games.dart';

class GamesProvider extends ChangeNotifier {
  String _baseUrl = 'zelda.fanapis.com';

  List<Games> onDisplayGames = [];

  //CONSTRUCTOR
  GamesProvider() {
    getallGames();
  }

  getallGames() async {
    var url = Uri.https(
      _baseUrl,
      'zelda.fanapis.com/api/games',
    );
    final response = await http.get(
        url); //aqui espera a recibir informacion por eso await, y hacemos un get

    final Map<String, dynamic> decodeData = json.decode(response.body);
    // print(decodeData);
    //print(response.body);
    final allGames = AllGames.fromRawJson(response.body);
    onDisplayGames = allGames.data;
    //Le comunicamos a todos los widgets que estan escuchando que se cambio la data por lo tanto se tienen que redibujar
    notifyListeners();
    print(allGames.data[0].name);
  } //peticiones asincronas es async
}
