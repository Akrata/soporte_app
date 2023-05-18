import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:soporte_app/models/responses/equipo_response.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:http/http.dart' as http;

class EquiposRequest extends ChangeNotifier {
  late Equipo equipoActual;
  Equipo equipoParaAgregar = Equipo(id: '', nombre: '', ip: '', sector: '');

  final pb = PocketBase('http://${DB.dbIp}');

  List<Equipo> listaEquipos = [];

  String sucursal = '';

//PARA BUSQUEDA
  List<Equipo> listaBusquedaEquipos = [];
  bool inSearch = false;
  TextEditingController controller = TextEditingController();

  EquiposRequest() {
    getEquipos();
    realTime();
    notifyListeners();
  }

  getEquipos() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/equipo/records',
          {'expand': 'sector.sucursal'}),
    );
    final data = EquipoResponse.fromJson(response.body);
    listaEquipos = data.items;

    notifyListeners();
  }

  // buscarEquipos() async {
  //   print('jhas');
  //   final response = await http.get(
  //     Uri.http(DB.dbIp, '/api/collections/equipo/records', {
  //       'expand': 'sector.sucursal',
  //       'filter': 'nombre~"$searchText"|| ip~"$searchText"'
  //     }),
  //   );
  //   final data = EquipoResponse.fromJson(response.body);
  //   listaEquipos = data.items;

  //   notifyListeners();
  // }

//PARA BUSQUEDA

  enBusqueda(bool dato) {
    inSearch = dato;
    notifyListeners();
  }

  busquedaEnLista(texto) {
    listaBusquedaEquipos = listaEquipos
        .where((element) =>
            element.nombre.toLowerCase().contains(texto) ||
            element.ip.toLowerCase().contains(texto) ||
            element.expand!.sector.nombre.toLowerCase().contains(texto) ||
            element.expand!.sector.expand!.sucursal.nombre
                .toLowerCase()
                .contains(texto))
        .toList();
  }

  realTime() async {
    try {
      final real = pb.collection('equipo').subscribe('*', (e) {
        print(e);

        getEquipos();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  deleteEquipo(String id) async {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collections/equipo/records/$id'),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  editEquipo(Equipo equipo) async {
    try {
      final reponse = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/equipo/records/${equipo.id}'),
        headers: {"Content-Type": "application/json"},
        body: equipo.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarEquipo(Equipo equipo) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/equipo/records"),
          body: equipo.toJson(),
          encoding: utf8,
          headers: {"Content-Type": "application/json"});
      limpiarEquipo();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarEquipo() {
    equipoParaAgregar = Equipo(id: '', nombre: '', ip: '', sector: '');
    sucursal = '';
  }
}
