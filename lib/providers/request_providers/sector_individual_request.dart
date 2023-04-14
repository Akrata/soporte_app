import 'package:flutter/material.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/models/impresora.dart';
import 'package:soporte_app/models/pinpad.dart';
import 'package:soporte_app/models/responses/equipo_response.dart';
import 'package:soporte_app/models/responses/impresora_response.dart';
import 'package:soporte_app/models/responses/pinpad_response.dart';
import 'package:soporte_app/models/responses/telefono_response.dart';
import 'package:soporte_app/models/responses/ups_response.dart';
import 'package:soporte_app/models/telefono.dart';
import 'package:soporte_app/models/ups.dart';

import 'package:http/http.dart' as http;

import '../../DB/db.dart';
import '../../models/sector.dart';

class SectorIndividualRequest extends ChangeNotifier {
  List<Equipo> listaEquipos = [];
  List<Impresora> listaImpresoras = [];
  List<Telefono> listaTelefonos = [];
  List<Ups> listaUps = [];
  List<Pinpad> listaPinpad = [];

  SectorIndividualRequest() {}
  obtenerEquipos(String idSector) async {
    try {
      final response = await http.get(Uri.http(
          DB.dbIp,
          '/api/collections/equipo/records',
          {'expand': 'sector.sucursal', 'filter': 'sector.id~"$idSector"'}));
      print('data---->>> ${response.body}');
      final data = EquipoResponse.fromJson(response.body);
      listaEquipos = data.items;
      print('listaEquipos $listaEquipos');
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  obtenerImpresoras(String idSector) async {
    try {
      final response = await http.get(Uri.http(
          DB.dbIp,
          '/api/collections/impresora/records',
          {'expand': 'sector.sucursal', 'filter': 'sector.id~"$idSector"'}));
      final data = ImpresoraResponse.fromJson(response.body);
      listaImpresoras = data.items;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  obtenerTelefonos(String idSector) async {
    try {
      final response = await http.get(Uri.http(
          DB.dbIp,
          '/api/collections/telefono/records',
          {'expand': 'sector.sucursal', 'filter': 'sector.id~"$idSector"'}));
      final data = TelefonoResponse.fromJson(response.body);
      listaTelefonos = data.items;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  obtenerUps(String idSector) async {
    try {
      final response = await http.get(Uri.http(
          DB.dbIp,
          '/api/collections/ups/records',
          {'expand': 'sector.sucursal', 'filter': 'sector.id~"$idSector"'}));
      final data = UpsResponse.fromJson(response.body);
      listaUps = data.items;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  obtenerPinpad(String idSector) async {
    try {
      final response = await http.get(Uri.http(
          DB.dbIp,
          '/api/collections/pinpad/records',
          {'expand': 'equipo.sector', 'filter': 'sector.id~"$idSector"'}));
      final data = PinpadResponse.fromJson(response.body);
      listaPinpad = data.items;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
