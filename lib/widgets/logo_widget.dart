import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  //const name({Key key}) : super(key: key);
  final String titulo;

  const LogoWidget({Key key, @required this.titulo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 80),
        //color: Colors.black,
        child: Column(
          children: [
            Image(image: AssetImage('assets/tag-logo.png')),
            SizedBox(height: 20),
            Text(this.titulo, style: TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}
