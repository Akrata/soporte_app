import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:http/http.dart' as http;
import 'package:soporte_app/models/impresora.dart';
import 'package:soporte_app/models/responses/sector_response.dart';
import 'package:soporte_app/models/responses/solicitud_toner_response.dart';
import 'package:soporte_app/models/responses/toner_response.dart';
import 'package:soporte_app/models/sector.dart';
import 'package:soporte_app/models/solicitud_toner.dart';
import 'package:soporte_app/models/sucursal.dart';
import 'package:soporte_app/models/toner.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../models/responses/impresora_response.dart';

class SolicitudTonerRequest extends ChangeNotifier {
  final pb = PocketBase('http://${DB.dbIp}');

  final urlGet = Uri.http(DB.dbIp, '/api/collections/solicitud_toner/records', {
    'expand': 'sector.sucursal, toner,users',
    'perPage': '50',
    'sort': 'entregado,-created'
  });

  List<SolicitudToner> listaSolicitudToner = [];
  List<Sector> listaSectoresValue = [];
  List<Impresora> listaImpresorasValue = [];
  List<Toner> listaTonerValue = [];

  SolicitudTonerRequest() {
    getSolicitudToner();
    realTime();
  }

  realTime() {
    try {
      final real = pb.collection('solicitud_toner').subscribe('*', (e) {
        print(e);
        Future.delayed(
          Duration(milliseconds: 500),
          () {
            getSolicitudToner();
          },
        );
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  getSolicitudToner() async {
    try {
      final response = await http.get(urlGet);

      // print(response.body);
      final data = SolicitudTonerResponse.fromJson(response.body);
      listaSolicitudToner = data.items;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  entregarToner(SolicitudToner solTnr, bool value, String user) async {
    solTnr.entregado = value;
    solTnr.users = user;
    print(user);
    final data = solTnr.toJson();

    try {
      final reponse = await http.patch(
        Uri.http(
            DB.dbIp, '/api/collections/solicitud_toner/records/${solTnr.id}'),
        headers: {"Content-Type": "application/json"},
        body: data,
        encoding: utf8,
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarSolicitud(SolicitudToner toner) {}

  getSectorSegunSucursal(filtro) async {
    final response = await http.get(Uri.http(
        DB.dbIp,
        '/api/collections/sector/records',
        {'expand': 'sucursal', 'filter': "sucursal.id='$filtro'"}));

    final data = SectorResponse.fromJson(response.body);
    listaSectoresValue = data.items;
    notifyListeners();
  }

  getImpresoraSegunSector(filtro) async {
    final response = await http.get(Uri.http(
        DB.dbIp,
        '/api/collections/impresora/records',
        {'expand': 'sector.sucursal,toner', 'filter': "sector.id='$filtro'"}));
    // print(response.body);
    final data = ImpresoraResponse.fromJson(response.body);
    listaImpresorasValue = data.items;
    notifyListeners();
  }

  getTonerSegunImpresora(filtro) async {
    final response = await http.get(Uri.http(
        DB.dbIp,
        '/api/collections/impresora/records',
        {'expand': 'toner', 'filter': "id='$filtro'"}));
    // print(response.body);
    final data = TonerResponse.fromJson(response.body);
    listaTonerValue = data.items;
    notifyListeners();
  }
}
