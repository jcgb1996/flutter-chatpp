import 'package:chatapp/global/enviroment.dart';
import 'package:chatapp/models/mensaje_response.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chatapp/models/usuario.dart';

class ChatServices with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final resp = await http.get(
      '${Enviroment.apiUrl}/mensajes/$usuarioID',
      headers: {
        'content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      },
    );

    final mensajeResp = mensajesResponseFromJson(resp.body);

    return mensajeResp.mensaje;
  }
}
