import 'package:chatapp/global/enviroment.dart';
import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/models/usuario_response.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  Future<List<Usuario>> getUsuario() async {
    try {
      final response = await http.get(
        '${Enviroment.apiUrl}/usuarios',
        headers: {
          'content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        },
      );

      final usuarioResponde = usuariosResponseFromJson(response.body);
      return usuarioResponde.usuario;
    } catch (e) {
      return [];
    }
  }
}
