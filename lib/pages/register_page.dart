import 'package:chatapp/widgets/btn_azul.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/custom_inpus.dart';
import 'package:chatapp/widgets/label_widget.dart';
import 'package:chatapp/widgets/logo_widget.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LogoWidget(
                    titulo: 'Registro',
                  ),
                  _Form(),
                  LabelWidget(
                    titulo: 'Ya tienes cuenta',
                    subtitulo: 'Ingresa ahora',
                    ruta: 'login',
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Terminos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  // _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
              icon: Icons.perm_identity,
              placeHolder: 'Nombre',
              keybordType: TextInputType.text,
              textEditingController: nameCtrl),

          CustomInput(
              icon: Icons.email,
              placeHolder: 'Nombre',
              keybordType: TextInputType.emailAddress,
              textEditingController: emailCtrl),

          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Correo',
            textEditingController: passwordCtrl,
            isPassrword: true,
          ),
          BtnAzul(
              text: 'Ingrese',
              onpress: () {
                // Navigator.pushReplacementNamed(context, 'register');
              }),
          //CustomInput(),
        ],
      ),
    );
  }
}
