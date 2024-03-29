// ignore_for_file: depend_on_referenced_packages, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:soporte_app/models/conmutador.dart';
import 'package:soporte_app/models/responses/conmutador_response.dart';
import 'package:http/http.dart' as http;

class ConmutadorRequest extends ChangeNotifier {
  late Conmutador conmutadorActual;
  Conmutador conmutadorParaAgregar =
      Conmutador(id: '', nombre: '', ip: '', sucursal: '', observaciones: '');

  final pb = PocketBase('http://${DB.dbIp}');

  List<Conmutador> listaConmutadores = [];

  //PARA BUSQUEDA
  List<Conmutador> listaBusquedaConmutador = [];
  bool inSearch = false;
  TextEditingController controller = TextEditingController();

  ConmutadorRequest() {
    getConmutador();
    realTime();
    notifyListeners();
  }

  enBusqueda(bool dato) {
    inSearch = dato;
    notifyListeners();
  }

  busquedaEnLista(texto) {
    listaBusquedaConmutador = listaConmutadores
        .where((element) =>
            element.nombre.toLowerCase().contains(texto) ||
            element.ip.toLowerCase().contains(texto) ||
            element.expand!.sucursal.nombre.toLowerCase().contains(texto))
        .toList();
  }

  getConmutador() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/conmutador/records',
          {'expand': 'sucursal', 'sort': 'ip'}),
    );
    final data = ConmutadorResponse.fromJson(response.body);
    listaConmutadores = data.items;

    notifyListeners();
  }

  realTime() async {
    try {
      final real = pb.collection('conmutador').subscribe('*', (e) {
        print(e);

        getConmutador();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  deleteConmutador(String id) async {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collections/conmutador/records/$id'),
      );

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  editConmutador(Conmutador conmutador) async {
    try {
      final response = await http.patch(
        Uri.http(
            DB.dbIp, '/api/collections/conmutador/records/${conmutador.id}'),
        headers: {"Content-Type": "application/json"},
        body: conmutador.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarConmutador(Conmutador conmutador) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/conmutador/records"),
          body: conmutador.toJson(),
          encoding: utf8,
          headers: {"Content-Type": "application/json"});
      limpiarConmutador();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarConmutador() {
    Conmutador(id: '', nombre: '', ip: '', sucursal: '', observaciones: '');
  }
}
