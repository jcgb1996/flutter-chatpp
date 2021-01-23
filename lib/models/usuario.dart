import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.onLine,
    this.nombre,
    this.email,
    this.uid,
  });

  bool onLine;
  String nombre;
  String email;
  String uid;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        onLine: json["onLine"],
        nombre: json["nombre"],
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "onLine": onLine,
        "nombre": nombre,
        "email": email,
        "uid": uid,
      };
}
