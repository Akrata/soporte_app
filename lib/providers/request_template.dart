import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

import '../DB/db.dart';

class RequestTemplate extends ChangeNotifier {
  final pb = PocketBase('http://${DB.dbIp}');
  List listaGlobal = [];

  realTime(String collection, func) async {
    try {
      final real = pb.collection(collection).subscribe('*', (e) {
        print(e);

        func();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  get(Function(String) desdeJson, List lista, String collection,
      Map<String, dynamic> expand) async {
    try {
      final response = await http.get(Uri.http(DB.dbIp,
          '/api/collections/$collection/records', {'expand': '$expand'}));
      final data = desdeJson(response.body);
      listaGlobal = data.items;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  edit(model, String collection) async {
    try {
      final reponse = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/$collection/records/${model.id}'),
        headers: {"Content-Type": "application/json"},
        body: model.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  delete(String collection, modelId) {
    try {
      final response = http.delete(
        Uri.http(DB.dbIp, 'api/collection/$collection/records/$modelId'),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  create(model, String collection, Function? funcLimpiar) async {
    try {
      final response = await http
          .post(Uri.http(DB.dbIp, "/api/collections/$collection/records"),
              body: model.toJson(),
              // encoding: utf8,
              headers: {"Content-Type": "application/json"});
      funcLimpiar;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
