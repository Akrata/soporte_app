import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:http/http.dart' as http;
import '../../models/users.dart';

class AuthWithPass extends ChangeNotifier {
  final pb = PocketBase("http://${DB.dbIp}");
  bool isAuth = false;
  bool isSuperUser = false;
  String actualUser = '';

  bool mostrarAlerta = false;

  late Users usuario;

  authUser(String usernameOrEmail, String password) async {
    try {
      final authData = await pb
          .collection('users')
          .authWithPassword(usernameOrEmail, password);
      isAuth = pb.authStore.isValid;

      // actualUser = pb.authStore.model.username;
      obtenerUsuario(pb.authStore.model.id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  logOut() {
    pb.authStore.clear();
    actualUser = '';
    isAuth = pb.authStore.isValid;
  }

  obtenerUsuario(filtro) async {
    try {
      final response = await http
          .get(Uri.http(DB.dbIp, '/api/collections/users/records/$filtro'));
      // print(response.body);
      final data = Users.fromJson(response.body);
      usuario = data;
    } catch (e) {
      print(e);
    }
  }
}
