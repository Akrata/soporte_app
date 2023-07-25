// ignore_for_file: depend_on_referenced_packages, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:soporte_app/models/responses/licencia_response.dart';
import 'package:http/http.dart' as http;

import '../../models/licencia.dart';

class LicenciaRequest extends ChangeNotifier {
  late Licencia licenciaActual;
  Licencia licenciaParaAgregar = Licencia(id: '', key: '', tipo: '');

  final pb = PocketBase('http://${DB.dbIp}');

  List<Licencia> listaLicencia = [];

  //PARA BUSQUEDA
  List<Licencia> listaBuscarLicencia = [];
  bool inSearch = false;
  TextEditingController controller = TextEditingController();

  LicenciaRequest() {
    getLicencia();
    realTime();
    notifyListeners();
  }

  enBusqueda(bool dato) {
    inSearch = dato;
    notifyListeners();
  }

  busquedaEnLista(texto) {
    listaBuscarLicencia = listaLicencia
        .where((element) =>
            element.key.toLowerCase().contains(texto) ||
            element.tipo.toLowerCase().contains(texto) ||
            element.expand!.equipo.nombre.toLowerCase().contains(texto))
        .toList();
  }

  getLicencia() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/licencia/records',
          {'expand': 'equipo.sector.sucursal'}),
    );
    print(response.body);
    final data = LicenciaResponse.fromJson(response.body);
    listaLicencia = data.items;
    print(listaLicencia[0]);
    notifyListeners();
  }

  realTime() async {
    try {
      final real = pb.collection('licencia').subscribe('*', (e) {
        print(e);

        getLicencia();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  deleteLicencia(String id) async {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collections/licencia/records/$id'),
      );

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  editLicencia(Licencia licencia) async {
    try {
      final response = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/licencia/records/${licencia.id}'),
        headers: {"Content-Type": "application/json"},
        body: licencia.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarLicencia(Licencia licencia) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/licencia/records"),
          body: licencia.toJson(),
          encoding: utf8,
          headers: {"Content-Type": "application/json"});
      limpiarLicencia();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarLicencia() {
    Licencia(id: '', key: '', tipo: '');
  }
}
