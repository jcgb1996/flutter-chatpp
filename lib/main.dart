import 'package:chatapp/services/chat_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/routes/routes.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => SocketService()),
        ChangeNotifierProvider(create: (context) => ChatServices()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Char App',
        initialRoute: 'loading',
        routes: appRoute,
      ),
    );
  }
}
