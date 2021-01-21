import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeHolder;
  final TextEditingController textEditingController;
  final TextInputType keybordType;
  final bool isPassrword;

  const CustomInput({
    Key key,
    @required this.icon,
    @required this.placeHolder,
    @required this.textEditingController,
    this.keybordType = TextInputType.text,
    this.isPassrword = false,
  }) : super(key: key);
  //const name({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5)
        ],
      ),
      child: TextField(
        controller: this.textEditingController,
        autocorrect: false,
        keyboardType: this.keybordType,
        obscureText: this.isPassrword,
        decoration: InputDecoration(
            prefixIcon: Icon(this.icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: this.placeHolder),
      ),
    );
  }
}
