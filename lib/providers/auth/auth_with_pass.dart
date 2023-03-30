import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';

class AuthWithPass extends ChangeNotifier {
  final pb = PocketBase("http://${DB.dbIp}");
  bool isAuth = false;
  bool isSuperUser = false;
  String actualUser = '';

  bool mostrarAlerta = false;

  authUser(String usernameOrEmail, String password) async {
    try {
      final authData = await pb
          .collection('users')
          .authWithPassword(usernameOrEmail, password);
      isAuth = pb.authStore.isValid;
      actualUser = pb.authStore.model.username;
      print(actualUser);
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
}
