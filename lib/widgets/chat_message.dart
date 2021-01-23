import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  //const ChatMessage({Key key}) : super(key: key);

  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key key,
    @required this.texto,
    @required this.uid,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      child: FadeTransition(
        opacity: animationController,
        child: Container(
          child: this.uid == authService.usuario.uid
              ? _myMessage()
              : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 5, left: 50, right: 5),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(8.0),
        child: Text(
          this.texto,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 50),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(8.0),
        child: Text(
          this.texto,
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
