import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/services/usuarios_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usurioServices = new UsuarioService();
  List<Usuario> usuarios = [];

  @override
  void initState() {
    super.initState();
    this._cargarUsaurio();
  }

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authServices.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child:
                Text(usuario.nombre, style: TextStyle(color: Colors.black87))),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () {
            socketService.disconnect();
            AuthService.delteToken();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(Icons.check_circle, color: Colors.blue)
                : Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        key: Key('value'),
        controller: _refreshController,
        onRefresh: _cargarUsaurio,
        child: _listViewUsuario(),
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
        enablePullDown: true,
      ), //_listViewUsuario(),
    );
  }

  Widget _listViewUsuario() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuarios) {
    return ListTile(
      title: Text(usuarios.nombre),
      subtitle: Text(usuarios.email),
      leading: CircleAvatar(
        child: Text(
          usuarios.nombre.substring(0, 2),
        ),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuarios.onLine ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatServices>(context, listen: false);
        chatService.usuarioPara = usuarios;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  void _cargarUsaurio() async {
    this.usuarios = await usurioServices.getUsuario();
    setState(() {});

    _refreshController.refreshCompleted();
  }
}
