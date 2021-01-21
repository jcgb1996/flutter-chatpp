import 'package:flutter/material.dart';

class BtnAzul extends StatelessWidget {
  //Function onpress =>
  //const BtnAzul({Key key}) : super(key: key);

  final String text;
  final Function onpress;

  const BtnAzul({
    Key key,
    @required this.text,
    @required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.onpress,
      elevation: 2,
      highlightElevation: 8,
      color: Colors.blue,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            'Ingrese',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
