import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:http/http.dart' as http;
import 'package:soporte_app/models/responses/solicitud_toner_response.dart';
import 'package:soporte_app/models/solicitud_toner.dart';
import 'package:soporte_app/models/toner.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';
import 'package:pocketbase/pocketbase.dart';

class SolicitudTonerRequest extends ChangeNotifier {
  final pb = PocketBase('http:${DB.dbIp}');

  final urlGet = Uri.http(DB.dbIp, '/api/collections/solicitud_toner/records', {
    'expand': 'sector.sucursal, toner,users',
    'perPage': '50',
    'sort': 'entregado,-created'
  });

  List<SolicitudToner> listaSolicitudToner = [];

  SolicitudTonerRequest() {
    getSolicitudToner();
    realTime();
  }

  getSolicitudToner() async {
    try {
      final response = await http.get(urlGet);
      print(response.body);
      final data = SolicitudTonerResponse.fromJson(response.body);
      listaSolicitudToner = data.items;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  entregarToner(SolicitudToner solTnr, bool value, String user) async {
    solTnr.entregado = value;
    solTnr.users = user;
    print(user);
    final data = solTnr.toJson();

    try {
      final reponse = await http.patch(
        Uri.http(
            DB.dbIp, '/api/collections/solicitud_toner/records/${solTnr.id}'),
        headers: {"Content-Type": "application/json"},
        body: data,
        encoding: utf8,
      );
      Future.delayed(
        Duration(seconds: 1),
        () {
          getSolicitudToner();
        },
      );

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  realTime() {
    try {
      pb.collection('solicitud_toner').subscribe('*', (e) {
        Future.delayed(
          Duration(seconds: 1),
          () {
            getSolicitudToner();
          },
        );
      });
    } catch (e) {
      print(e);
    }
  }
}
