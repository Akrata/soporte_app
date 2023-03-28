import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';

class AuthWithPass extends ChangeNotifier {
  final pb = PocketBase("http://${DB.dbIp}");
  bool isAuth = false;
  bool isSuperUser = false;

  bool mostrarAlerta = false;

  authUser(String usernameOrEmail, String password) async {
    try {
      final authData = await pb
          .collection('users')
          .authWithPassword(usernameOrEmail, password);
      isAuth = pb.authStore.isValid;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  logOut() {
    pb.authStore.clear();
    isAuth = pb.authStore.isValid;
  }
}
