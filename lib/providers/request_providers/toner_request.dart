import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:soporte_app/models/responses/toner_response.dart';
import 'package:soporte_app/models/toner.dart';
import 'package:http/http.dart' as http;

class TonerRequest extends ChangeNotifier {
  final pb = PocketBase('http://${DB.dbIp}');

  List<Toner> listaToners = [];

  TonerRequest() {
    getToners();
  }

  getToners() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/toner/records'),
    );
    print(response.body);
    final data = TonerResponse.fromJson(response.body);
    print(data.items);
    listaToners = data.items;

    notifyListeners();
  }

  realTime() {
    try {
      final real = pb.collection('toner').subscribe('*', (e) {
        print(e);

        getToners();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }
}
