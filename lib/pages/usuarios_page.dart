import 'package:chatapp/models/usuario.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(nombre: 'Jose Carlos', email: 'lala@hotmail.com', onLine: true),
    Usuario(nombre: 'Maria Fernanda', email: 'lolo@hotmail.com', onLine: true),
    Usuario(
        nombre: 'Jeniffer Gonzalez', email: 'lili@hotmail.com', onLine: true),
    Usuario(
        nombre: 'Maribel Barrezueta', email: 'lele@hotmail.com', onLine: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Mi nombre', style: TextStyle(color: Colors.black87))),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue),
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
    );
  }

  void _cargarUsaurio() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
