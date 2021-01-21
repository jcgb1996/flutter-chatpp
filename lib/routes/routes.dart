import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/loading_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoute = {
  'usuarios': (_) => UsuariosPage(),
  'login': (_) => LoginPage(),
  'chat': (_) => ChatPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadinPage(),
};
