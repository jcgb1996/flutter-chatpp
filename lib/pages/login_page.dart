import 'package:chatapp/helper/mostrar_alerta.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/widgets/btn_azul.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/custom_inpus.dart';
import 'package:chatapp/widgets/label_widget.dart';
import 'package:chatapp/widgets/logo_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
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
                  LogoWidget(titulo: 'Messenger'),
                  _Form(),
                  LabelWidget(
                      titulo: 'No tienes cuenta',
                      subtitulo: 'Crea uno ahora!',
                      ruta: 'register'),
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
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
              icon: Icons.mail_outline,
              placeHolder: 'Correo',
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
              onpress: authServices.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final loginOk = await authServices.login(
                          emailCtrl.text.trim(), passwordCtrl.text.trim());

                      if (loginOk) {
                        socketService.connect();
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        mostrarAlerta(context, 'Login incorrecto',
                            'Revise sus credenciales');
                      }
                      //Navigator.pushReplacementNamed(context, 'register');
                    }),
          //CustomInput(),
        ],
      ),
    );
  }
}
