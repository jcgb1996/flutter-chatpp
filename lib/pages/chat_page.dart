import 'dart:io';
import 'package:chatapp/models/mensaje_response.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  ChatServices chatServices;
  SocketService socketService;
  AuthService authService;

  bool estaEscribiendo = false;

  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    this.chatServices = Provider.of<ChatServices>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('mensaje-personal', (data) {
      print('${data['Mensaje']}');
      if (data != null) {
        ChatMessage message = new ChatMessage(
          texto: data['Mensaje'],
          uid: data['de'],
          animationController: new AnimationController(
            vsync: this,
            duration: Duration(milliseconds: 300),
          ),
        );

        setState(() {
          _messages.insert(0, message);
        });
        message.animationController.forward();
      }
    });

    _cargarHistorial(this.chatServices.usuarioPara.uid);
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje> chat = await this.chatServices.getChat(usuarioID);
    final History = chat.map(
      (m) => new ChatMessage(
        texto: m.mensaje,
        uid: m.de,
        animationController: AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 0),
        )..forward(),
      ),
    );

    setState(() {
      _messages.insertAll(0, History);
    });

    print(chat);
  }

  @override
  Widget build(BuildContext context) {
    final usuarioPara = chatServices.usuarioPara;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[200],
          title: Column(
            children: [
              CircleAvatar(
                child: Text(usuarioPara.nombre.substring(0, 2),
                    style: TextStyle(fontSize: 12)),
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
              ),
              SizedBox(height: 3),
              Text(
                usuarioPara.nombre,
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _messages[index];
                  },
                  reverse: true,
                ),
              ),
              Divider(height: 1),
              Container(
                //color: Colors.white,
                height: 50,
                child: _inputChat(),
              )
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: (value) {
                _handleSubmit(value);
              },
              onChanged: (value) {
                setState(() {
                  if (value.trim().length > 0) {
                    estaEscribiendo = true;
                  } else {
                    estaEscribiendo = false;
                  }
                });
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Enviar mensaje',
              ),
              focusNode: _focusNode,
            ),
          ),

          //boton de enviar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: () {},
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.send),
                        onPressed: estaEscribiendo
                            ? () => _handleSubmit(_textController.text.trim())
                            : null, //() {},
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;

    //print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMesaage = new ChatMessage(
      texto: texto,
      uid: authService.usuario.uid,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMesaage);
//
    newMesaage.animationController.forward();

    setState(() {
      estaEscribiendo = false;
    });

    /*emite el mensaje personal */
    this.socketService.emit('mensaje-personal', {
      'de': this.authService.usuario.uid,
      'para': this.chatServices.usuarioPara.uid,
      'Mensaje': texto,
    });
  }

  @override
  void dispose() {
    // TODO: off del socket

    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    this.socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}
