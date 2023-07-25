import 'package:flutter/material.dart';
import 'package:soporte_app/DB/db.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:soporte_app/models/responses/sucursal_response.dart';
import 'package:soporte_app/models/sucursal.dart';
import 'package:pocketbase/pocketbase.dart';

class SucursalesRequest extends ChangeNotifier {
  final url = Uri.http(DB.dbIp, '/api/collections/sucursal/records', {});
  final pb = PocketBase('http://${DB.dbIp}');

  List<Sucursal> listaSucursales = [];

  //PARA BUSQUEDA
  List<Sucursal> listaBusquedaSucursal = [];
  bool inSearch = false;
  String textoBusqueda = '';
  TextEditingController controller = TextEditingController();

  SucursalesRequest() {
    getSucursales();
    notifyListeners();
  }
  enBusqueda(bool dato) {
    inSearch = dato;
    notifyListeners();
  }

  busquedaEnLista(texto) {
    listaBusquedaSucursal = listaSucursales
        .where((element) => element.nombre.toLowerCase().contains(texto))
        .toList();
  }

  getSucursales() async {
    final response = await http.get(url);
    final data = SucursalResponse.fromJson(response.body);
    listaSucursales = data.items;
    notifyListeners();
  }
}
