import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../DB/db.dart';

class AppStatusRequest extends ChangeNotifier {
  AppStatusRequest() {
    checkServerStatus();
  }

  Future<bool> checkServerStatus() async {
    try {
      final response = await http.get(
        Uri.http(
          DB.dbIp,
          '/api/collections/equipo/records',
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      print('Error: $e');
    }
  }

  Future<bool> fetchData() async {
    var url = Uri.parse(
        'https://projectkeys-ffe1c-default-rtdb.firebaseio.com/apps.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // La solicitud fue exitosa
      // print(response.body);
      var jsonData = jsonDecode(response.body);
      var enabled = jsonData['soporte_app']['enabled'];

      return enabled;

      // Aquí puedes realizar el procesamiento adicional de los datos recibidos
    } else {
      // La solicitud falló
      print('Error en la solicitud. Código de estado: ${response.statusCode}');
      return false;
    }
  }
}
