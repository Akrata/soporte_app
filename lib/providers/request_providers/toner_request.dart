import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:soporte_app/models/responses/toner_response.dart';
import 'package:soporte_app/models/toner.dart';
import 'package:http/http.dart' as http;

class TonerRequest extends ChangeNotifier {
  late Toner tonerActual;
  Toner tonerParaAgregar = Toner(
      id: '',
      modelo: '',
      stockMovilPoliclinico: 0,
      stockFijoPoliclinico: 0,
      stockMovilSanatorio: 0,
      stockFijoSanatorio: 0);

  final pb = PocketBase('http://${DB.dbIp}');

  List<Toner> listaToners = [];

  TonerRequest() {
    getToners();
    realTime();
  }

  getToners() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/toner/records'),
    );

    final data = TonerResponse.fromJson(response.body);

    listaToners = data.items;

    notifyListeners();
  }

  realTime() async {
    try {
      final real = pb.collection('toner').subscribe('*', (e) {
        print(e);

        getToners();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  deleteToner(String id) async {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collections/toner/records/$id'),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  editToner(Toner toner) async {
    try {
      final reponse = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/toner/records/${toner.id}'),
        headers: {"Content-Type": "application/json"},
        body: toner.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarToner(Toner toner) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/toner/records"),
          body: toner.toJson(),
          encoding: utf8,
          headers: {"Content-Type": "application/json"});
      limpiarToner();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarToner() {
    tonerParaAgregar = Toner(
        id: '',
        modelo: '',
        stockMovilPoliclinico: 0,
        stockFijoPoliclinico: 0,
        stockMovilSanatorio: 0,
        stockFijoSanatorio: 0);
  }
}
