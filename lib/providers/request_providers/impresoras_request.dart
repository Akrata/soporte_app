import 'package:flutter/material.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:http/http.dart' as http;
import 'package:soporte_app/models/impresora.dart';
import 'package:soporte_app/models/responses/impresora_response.dart';
import 'package:soporte_app/models/responses/sucursal_response.dart';
import 'package:soporte_app/models/sucursal.dart';
import 'package:pocketbase/pocketbase.dart';

class ImpresorasRequest extends ChangeNotifier {
  final url = Uri.http(DB.dbIp, '/api/collections/impresora/records', {});
  final pb = PocketBase('http://${DB.dbIp}');

  List<Impresora> listaImpresoras = [];
  Impresora impresoraParaAgregar =
      Impresora(id: '', marca: '', modelo: '', sector: '', toner: '', ip: '');
  String sucursal = '';

  ImpresorasRequest() {
    getImpresoras();
    realTime();
    notifyListeners();
  }

  // getImpresoras() async {
  //   final response = await http.get(url);
  //   final data = ImpresoraResponse.fromJson(response.body);
  //   listaImpresoras = data.items;
  //   notifyListeners();
  // }
  getImpresoras() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/impresora/records',
          {'expand': 'sector.sucursal, toner'}),
    );
    final data = ImpresoraResponse.fromJson(response.body);
    listaImpresoras = data.items;
    notifyListeners();
  }

  realTime() async {
    try {
      final real = pb.collection('impresora').subscribe('*', (e) {
        print(e);

        getImpresoras();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  deleteImpresora(String id) async {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collections/impresora/records/$id'),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  editImpresora(Impresora impresora) async {
    try {
      final reponse = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/impresora/records/${impresora.id}'),
        headers: {"Content-Type": "application/json"},
        body: impresora.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarImpresora(Impresora impresora) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/impresora/records"),
          body: impresora.toJson(),
          headers: {"Content-Type": "application/json"});
      limpiarImpresora();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarImpresora() {
    impresoraParaAgregar =
        Impresora(id: '', marca: '', modelo: '', sector: '', toner: '', ip: '');
    sucursal = '';
  }
}
