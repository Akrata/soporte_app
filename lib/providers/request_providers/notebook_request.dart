// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:soporte_app/models/responses/notebook_response.dart';
import 'package:http/http.dart' as http;

import '../../models/notebook.dart';

class NotebookRequest extends ChangeNotifier {
  late Notebook notebookActual;
  Notebook notebookParaAgregar =
      Notebook(id: '', marca: '', modelo: '', anio: '');

  final pb = PocketBase('http://${DB.dbIp}');

  List<Notebook> listaNotebook = [];

  //PARA BUSQUEDA
  List<Notebook> ListaBusquedaNotebook = [];
  bool inSearch = false;
  TextEditingController controller = TextEditingController();

  NotebookRequest() {
    getNotebooks();
    realTime();
    notifyListeners();
  }

  enBusqueda(bool dato) {
    inSearch = dato;
    notifyListeners();
  }

  busquedaEnLista(texto) {
    ListaBusquedaNotebook = listaNotebook
        .where((element) =>
            element.usuario!.toLowerCase().contains(texto) ||
            element.marca.toLowerCase().contains(texto) ||
            element.anio.toLowerCase().contains(texto) ||
            element.modelo.toLowerCase().contains(texto))
        .toList();
  }

  getNotebooks() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/notebook/records', {'sort': '-anio'}),
    );
    final data = NotebookResponse.fromJson(response.body);
    listaNotebook = data.items;

    notifyListeners();
  }

  realTime() async {
    try {
      final real = pb.collection('notebook').subscribe('*', (e) {
        print(e);

        getNotebooks();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  deleteNotebook(String id) async {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collections/notebook/records/$id'),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  editNotebook(Notebook notebook) async {
    try {
      final response = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/notebook/records/${notebook.id}'),
        headers: {"Content-Type": "application/json"},
        body: notebook.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarNotebook(Notebook notebook) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/notebook/records"),
          body: notebook.toJson(),
          encoding: utf8,
          headers: {"Content-Type": "application/json"});
      limpiarNotebook();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarNotebook() {
    notebookParaAgregar = Notebook(id: '', marca: '', modelo: '', anio: '');
  }
}
