import 'package:flutter/material.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:http/http.dart' as http;
import 'package:soporte_app/models/responses/solicitud_toner_response.dart';
import 'package:soporte_app/models/solicitud_toner.dart';

class SolicitudTonerRequest extends ChangeNotifier {
  final url = Uri.http(DB.dbIp, '/api/collections/solicitud_toner/records', {
    'expand': 'sector.sucursal, toner',
    'perPage': '50',
    'sort': 'entregado,-created'
  });

  List<SolicitudToner> listaSolicitudToner = [];

  SolicitudTonerRequest() {
    getSolicitudToner();
  }

  getSolicitudToner() async {
    final response = await http.get(url);
    print(response.body);
    final data = SolicitudTonerResponse.fromJson(response.body);
    listaSolicitudToner = data.items;
    notifyListeners();
  }

  getSucursales() async {}
}
