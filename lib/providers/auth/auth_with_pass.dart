// ignore_for_file: depend_on_referenced_packages, unused_local_variable, avoid_print

import 'dart:convert';

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

  AuthWithPass();

  authUser(String usernameOrEmail, String password) async {
    try {
      final authData = await pb
          .collection('users')
          .authWithPassword(usernameOrEmail, password);
      isAuth = pb.authStore.isValid;

      // actualUser = pb.authStore.model.username;
      await obtenerUsuario(pb.authStore.model.id);
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
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  cambiarSector(String id, String sector) async {
    try {
      final response = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/users/records/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"lugarTrabajo": sector}),
      );
      obtenerUsuario(id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
