import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  //const _Label({Key key}) : super(key: key);

  final String ruta;
  final String titulo;
  final String subtitulo;

  const LabelWidget({Key key, @required this.ruta, this.titulo, this.subtitulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.titulo,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
              // print('tab');
            },
            child: Text(this.subtitulo,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
