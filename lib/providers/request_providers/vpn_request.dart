// ignore_for_file: depend_on_referenced_packages, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';

import 'package:soporte_app/models/responses/vpn_response.dart';

import 'package:http/http.dart' as http;

import '../../models/vpn.dart';

class VpnRequest extends ChangeNotifier {
  late VPN vpnActual;
  VPN vpnParaAgregar = VPN(id: '', usuario: '', password: '');

  final pb = PocketBase('http://${DB.dbIp}');

  List<VPN> listaVpn = [];

  //PARA BUSQUEDA
  List<VPN> listaBusquedaVpn = [];
  bool inSearch = false;
  TextEditingController controller = TextEditingController();

  VpnRequest() {
    getVpn();
    realTime();
    notifyListeners();
  }

  enBusqueda(bool dato) {
    inSearch = dato;
    notifyListeners();
  }

  busquedaEnLista(texto) {
    listaBusquedaVpn = listaVpn
        .where((element) =>
            element.usuario.toLowerCase().contains(texto) ||
            element.password.toLowerCase().contains(texto) ||
            element.nombreDeContacto!.toLowerCase().contains(texto) ||
            element.nombreDeContacto!.toLowerCase().contains(texto) ||
            element.anydesk!.toLowerCase().contains(texto))
        .toList();
  }

  getVpn() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/vpn/records', {'sort': '-updated'}),
    );
    final data = VpnResponse.fromJson(response.body);
    listaVpn = data.items;

    notifyListeners();
  }

  realTime() async {
    try {
      final real = pb.collection('vpn').subscribe('*', (e) {
        print(e);

        getVpn();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  deleteVpn(String id) async {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collections/vpn/records/$id'),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  editVpn(VPN vpn) async {
    try {
      final response = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/vpn/records/${vpn.id}'),
        headers: {"Content-Type": "application/json"},
        body: vpn.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarVpn(VPN vpn) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/vpn/records"),
          body: vpn.toJson(),
          encoding: utf8,
          headers: {"Content-Type": "application/json"});
      limpiarVpn();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarVpn() {
    vpnParaAgregar = VPN(id: '', usuario: '', password: '');
  }
}
