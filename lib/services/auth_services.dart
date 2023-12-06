import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'LoginPruebaEdwin2023.somee.com';
  //final String _firebaseToken = 'AIzaSyCD36g1c5N9WPp4PCmVwt2jEzdWIGtglso';

  final storage = new FlutterSecureStorage();

  // Si retornamos algo, es un error, si no, todo bien!
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      //'returnSecureToken': true
    };

    final url = Uri.http(_baseUrl, '/api/Cuentas/registrar');

    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['token']);
    
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }//-----------------------------------------------------------

  Future<String?> login(String email, String password) async {//-----------------------------------------------------------
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url = Uri.http(_baseUrl, '/api/Cuentas/Login');

 

    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData));

  
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      // Token hay que guardarlo en un lugar seguro
      // decodedResp['idToken'];
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }//-----------------------------------------------------------

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }


  Future<String?> getUserId() async {
    try {
      final token = await readToken();

      if (token != null) {
        // Decodificar el token para obtener la información del usuario
        final Map<String, dynamic> decodedToken = json.decode(
          ascii.decode(base64.decode(base64.normalize(token.split(".")[1]))),
        );

        // Aquí asumimos que el ID del usuario está presente en el token
        if (decodedToken.containsKey('sub')) {
          return decodedToken['sub'];
        }
      }
    } catch (e) {
      print('Error al obtener el ID del usuario: $e');
    }

    return null;
  }

  
Future<void> agregarJuegoFavorito(String userId, String gameId) async {
  try {
    final Map<String, dynamic> data = {
      'id': 0,
      'userId': userId,
      'juegoId': gameId,
    };

    final url = Uri.http(_baseUrl, '/api/Cuentas/JuegoFavorito');

    final resp = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(data),
    );

    if (resp.statusCode == 200) {
      print('Juego favorito agregado con éxito');
    } else {
      print('Error al agregar juego favorito. Código de estado: ${resp.statusCode}');
    }
  } catch (error) {
    print('Excepción al agregar juego favorito: $error');
  }
}

 Future<List<Map<String, dynamic>>> obtenerJuegosFavoritos(String userId) async {
    try {
      final url = Uri.http(_baseUrl, '/api/Cuentas/$userId');

      final resp = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (resp.statusCode == 200) {
        final List<dynamic> data = json.decode(resp.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        print('Error al obtener juegos favoritos. Código de estado: ${resp.statusCode}');
        return [];
      }
    } catch (error) {
      print('Excepción al obtener juegos favoritos: $error');
      return [];
    }
  }

}
