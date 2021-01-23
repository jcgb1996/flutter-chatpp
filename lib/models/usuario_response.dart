// To parse this JSON data, do
//
//     final usuariosResponse = usuariosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chatapp/models/usuario.dart';

UsuariosResponse usuariosResponseFromJson(String str) =>
    UsuariosResponse.fromJson(json.decode(str));

String usuariosResponseToJson(UsuariosResponse data) =>
    json.encode(data.toJson());

class UsuariosResponse {
  UsuariosResponse({
    this.ok,
    this.usuario,
    this.desde,
  });

  bool ok;
  List<Usuario> usuario;
  int desde;

  factory UsuariosResponse.fromJson(Map<String, dynamic> json) =>
      UsuariosResponse(
        ok: json["ok"],
        usuario:
            List<Usuario>.from(json["usuario"].map((x) => Usuario.fromJson(x))),
        desde: json["desde"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": List<dynamic>.from(usuario.map((x) => x.toJson())),
        "desde": desde,
      };
}
