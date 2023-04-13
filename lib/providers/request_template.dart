import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

import '../DB/db.dart';

class RequestTemplate extends ChangeNotifier {
  final pb = PocketBase('http://${DB.dbIp}');

  realTime(String collection, Function func) async {
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

  get(model, List lista, String collection, String? expand) async {
    try {
      final response = await http.get(Uri.http(DB.dbIp,
          '/api/collections/$collection/records', {'expand': '$expand'}));
      final data = model.fromJson(response.body);
      lista = data.items;
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
