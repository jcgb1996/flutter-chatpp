import 'dart:convert';

import 'package:chatapp/global/enviroment.dart';
import 'package:chatapp/models/login_response.dart';
import 'package:chatapp/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as htttp;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  //getters del token de forma statica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = _storage.read(key: 'token');
    return token;
  }

  static Future<void> delteToken() async {
    final _storage = new FlutterSecureStorage();
    _storage.delete(key: 'token');
  }

  Future<bool> login(String usuario, String password) async {
    this.autenticando = true;
    final data = {
      "password": password,
      "email": usuario,
    };
    final url = Enviroment.apiUrl;
    final resp = await htttp.post('$url/login',
        body: jsonEncode(data), headers: {'content-Type': 'application/json'});

    print(resp.body);
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseModelFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;
    final data = {"nombre": nombre, "password": password, "email": email};

    final url = Enviroment.apiUrl;
    final resp = await htttp.post('$url/login/new',
        body: jsonEncode(data), headers: {'content-Type': 'application/json'});

    print(resp.body);

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseModelFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    //print(token);

    final url = Enviroment.apiUrl;
    final resp = await htttp.get('$url/login/renew',
        headers: {'content-Type': 'application/json', 'x-token': token});

    //print(resp.body);

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseModelFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
// Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
// Delete value
    await _storage.delete(key: 'token');
  }
}
