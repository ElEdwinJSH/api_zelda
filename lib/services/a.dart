/*Future<void> quitarJuegoFavorito(String userId, String gameId) async {
  try {
    final urlb = Uri.http(_baseUrl, '/api/Cuentas/$userId');

    final resp2 = await http.get(
      urlb,
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (resp2.statusCode == 200) {
      // Parsear la respuesta para obtener el ID del registro
      final Map<String, dynamic> userData = json.decode(resp2.body);
      final String registroId = userData['id'];
print(registroId);
      final Map<String, dynamic> data = {
        'id': registroId,
        'userId': userId,
        'juegoId': gameId,
      };

      final url = Uri.http(_baseUrl, '/api/Cuentas/EliminarJuegoFavorito');

      final resp = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(data),
      );

      if (resp.statusCode == 200) {
        print('Juego favorito eliminado con éxito');
      } else {
        print('Error al eliminar juego favorito. Código de estado: ${resp.statusCode}');
      }
    } else {
      print('Error al obtener datos del usuario. Código de estado: ${resp2.statusCode}');
    }
  } catch (error) {
    print('Excepción al eliminar juego favorito: $error');
  }
}














 //-----------------------QUITAR FAV
     try {
    final urlb = Uri.http(_baseUrl, '/api/Cuentas/$userId');

    final resp2 = await http.get(
      urlb,
      headers: {
        "Content-Type": "application/json",
      },
    );

  

    final List<dynamic> userDataList = json.decode(resp2.body);
    print('userda');
    print(userDataList);

    // Recorrer la lista de userData para buscar coincidencias
    for (final userData in userDataList) {
      print('a');
      print(userData);
     int registroId = userData['id'];
     print('id');
      print(registroId);

      // Verificar si userId y gameId coinciden con los de la base de datos
      if (userData['userId'] == userId && userData['juegoId'] == gameId) {

        print(userData['juegoId']);
        final Map<String, dynamic> data = {
          'id': registroId,
          'userId': userId,
          'juegoId': gameId,
        };

        final url = Uri.http(_baseUrl, '/api/Cuentas/EliminarJuegoFavorito');

        final resp = await http.delete(
          url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(data),
        );

        if (resp.statusCode == 200) {
          print('Juego favorito eliminado con éxito');
          return; // Salir de la función después de eliminar el juego favorito
        } else {
          print('Error al eliminar juego favorito. Código de estado: ${resp.statusCode}');
        }
      } else {
        print('userId y/o juegoId en los detalles no coinciden con la base de datos');
      }
    }

    // Si no se encontró coincidencia después de recorrer toda la lista
    print('No se encontraron coincidencias en la base de datos');
  } catch (error) {
    print('Excepción al eliminar juego favorito: $error');
  }*/