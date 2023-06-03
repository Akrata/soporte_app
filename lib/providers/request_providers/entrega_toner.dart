import 'package:flutter/material.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';

import '../../DB/db.dart';
import '../../models/responses/toner_response.dart';
import '../../models/toner.dart';
import 'package:http/http.dart' as http;

class EntregaToner extends ChangeNotifier {
  List<Toner> listaToners = [];

  EntregaToner() {
    getToners();
  }

  getToners() async {
    final response = await http.get(
      Uri.http(DB.dbIp, '/api/collections/toner/records'),
    );

    final data = TonerResponse.fromJson(response.body);

    listaToners = data.items;

    notifyListeners();
  }
}
