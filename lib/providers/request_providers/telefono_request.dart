import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:soporte_app/models/responses/equipo_response.dart';
import 'package:soporte_app/models/responses/telefono_response.dart';
import 'package:soporte_app/models/telefono.dart';
import 'package:http/http.dart' as http;
import 'package:soporte_app/models/responses/ups_response.dart';
import 'package:soporte_app/models/ups.dart';

class TelefonoRequest extends ChangeNotifier {
  late Telefono telefonoActual;
  Telefono telefonoParaAgregar =
      Telefono(id: '', nombre: '', interno: '', ip: '', sector: '');

  final pb = PocketBase('http://${DB.dbIp}');

  List<Telefono> listaTelefonos = [];
  String sucursal = '';

  //PARA BUSQUEDA
  List<Telefono> listaBusquedaTelefono = [];
  bool inSearch = false;
  TextEditingController controller = TextEditingController();

  TelefonoRequest() {
    getTelefonos();
    realTime();
    notifyListeners();
  }

  enBusqueda(bool dato) {
    inSearch = dato;
    notifyListeners();
  }

  busquedaEnLista(texto) {
    listaBusquedaTelefono = listaTelefonos
        .where((element) =>
            element.interno.toLowerCase().contains(texto) ||
            element.ip.toLowerCase().contains(texto) ||
            element.expand!.sector.nombre.toLowerCase().contains(texto) ||
            element.expand!.sector.expand!.sucursal.nombre
                .toLowerCase()
                .contains(texto))
        .toList();
  }

  getTelefonos() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/telefono/records',
          {'expand': 'sector.sucursal'}),
    );
    final data = TelefonoResponse.fromJson(response.body);
    listaTelefonos = data.items;

    notifyListeners();
  }

  realTime() async {
    try {
      final real = pb.collection('telefono').subscribe('*', (e) {
        print(e);

        getTelefonos();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  deleteTelefono(String id) async {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collections/telefono/records/$id'),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  editTelefono(Telefono tel) async {
    try {
      final reponse = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/telefono/records/${tel.id}'),
        headers: {"Content-Type": "application/json"},
        body: tel.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarTelefono(Telefono tel) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/telefono/records"),
          body: tel.toJson(),
          encoding: utf8,
          headers: {"Content-Type": "application/json"});
      limpiarTel();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarTel() {
    telefonoParaAgregar =
        Telefono(id: '', nombre: '', interno: '', ip: '', sector: '');
    sucursal = '';
  }
}
