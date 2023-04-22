import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:soporte_app/models/pinpad.dart';
import 'package:soporte_app/models/responses/equipo_response.dart';
import 'package:soporte_app/models/responses/pinpad_response.dart';
import 'package:soporte_app/models/responses/telefono_response.dart';
import 'package:soporte_app/models/telefono.dart';
import 'package:http/http.dart' as http;
import 'package:soporte_app/models/responses/ups_response.dart';
import 'package:soporte_app/models/ups.dart';

class PinpadRequest extends ChangeNotifier {
  late Pinpad pinpadActual;
  Pinpad pinpadParaAgregar = Pinpad(id: '', ip: '', sector: '');

  final pb = PocketBase('http://${DB.dbIp}');

  List<Pinpad> listaPinpad = [];
  String sucursal = '';

  PinpadRequest() {
    getPinpad();
    realTime();
    notifyListeners();
  }

  getPinpad() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/pinpad/records',
          {'expand': 'sector.sucursal'}),
    );
    final data = PinpadResponse.fromJson(response.body);
    listaPinpad = data.items;

    notifyListeners();
  }

  realTime() async {
    try {
      final real = pb.collection('pinpad').subscribe('*', (e) {
        print(e);

        getPinpad();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  deletePinpad(String id) async {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collections/pinpad/records/$id'),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  editPinpad(Pinpad pinpad) async {
    try {
      final reponse = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/pinpad/records/${pinpad.id}'),
        headers: {"Content-Type": "application/json"},
        body: pinpad.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarPinpad(Pinpad pinpad) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/pinpad/records"),
          body: pinpad.toJson(),
          encoding: utf8,
          headers: {"Content-Type": "application/json"});
      limpiarPinpad();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarPinpad() {
    pinpadParaAgregar = Pinpad(id: '', ip: '', sector: '');
    sucursal = '';
  }
}
