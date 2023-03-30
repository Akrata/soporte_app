import 'package:flutter/material.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:http/http.dart' as http;
import 'package:soporte_app/models/responses/sucursal_response.dart';
import 'package:soporte_app/models/sucursal.dart';
import 'package:pocketbase/pocketbase.dart';

class SucursalesRequest extends ChangeNotifier {
  final url = Uri.http(DB.dbIp, '/api/collections/sucursal/records', {});
  final pb = PocketBase('http://${DB.dbIp}');

  List<Sucursal> listaSucursales = [];
  String naombreSucursal = '';

  SucursalesRequest() {}

  getSucursales() async {
    final response = await http.get(url);
    final data = SucursalResponse.fromJson(response.body);
    listaSucursales = data.items;
    notifyListeners();
  }

  getSucursal(filtro) async {
    final record = await pb.collection('sucursal').getFirstListItem(
          'id=${filtro}',
        );
    @override
    String toString() => record.data['nombre'];
  }
}
