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

  ImpresorasRequest() {
    getImpresoras();
    notifyListeners();
  }

  getImpresoras() async {
    final response = await http.get(url);
    final data = ImpresoraResponse.fromJson(response.body);
    listaImpresoras = data.items;
    notifyListeners();
  }
}
