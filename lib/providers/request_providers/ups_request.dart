import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:soporte_app/models/responses/equipo_response.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:http/http.dart' as http;
import 'package:soporte_app/models/responses/ups_response.dart';
import 'package:soporte_app/models/ups.dart';

class UpsRequest extends ChangeNotifier {
  late Ups upsActual;
  Ups upsParaAgregar = Ups(id: 'id', marca: '', modelo: '', sector: '');

  final pb = PocketBase('http://${DB.dbIp}');

  List<Ups> listaUps = [];
  String sucursal = '';

  //PARA BUSQUEDA
  List<Ups> listaBusquedaUps = [];
  bool inSearch = false;

  UpsRequest() {
    getUps();
    realTime();
    notifyListeners();
  }

  enBusqueda(bool dato) {
    inSearch = dato;
    notifyListeners();
  }

  busquedaEnLista(texto) {
    listaBusquedaUps = listaUps
        .where((element) =>
            element.marca.toLowerCase().contains(texto) ||
            element.modelo.toLowerCase().contains(texto) ||
            element.expand!.sector.nombre.toLowerCase().contains(texto) ||
            element.expand!.sector.expand!.sucursal.nombre
                .toLowerCase()
                .contains(texto))
        .toList();
  }

  getUps() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/ups/records',
          {'expand': 'sector.sucursal'}),
    );
    final data = UpsResponse.fromJson(response.body);
    listaUps = data.items;

    notifyListeners();
  }

  realTime() async {
    try {
      final real = pb.collection('ups').subscribe('*', (e) {
        print(e);

        getUps();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  deleteUps(String id) async {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collections/ups/records/$id'),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  editUps(Ups ups) async {
    try {
      final reponse = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/ups/records/${ups.id}'),
        headers: {"Content-Type": "application/json"},
        body: ups.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarUps(Ups ups) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/ups/records"),
          body: ups.toJson(),
          encoding: utf8,
          headers: {"Content-Type": "application/json"});
      limpiarUps();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarUps() {
    upsParaAgregar = Ups(id: '', marca: '', modelo: '', sector: '');
    sucursal = '';
  }
}
