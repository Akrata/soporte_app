import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:soporte_app/DB/db.dart';
import 'package:soporte_app/models/responses/sector_response.dart';
import 'package:soporte_app/models/sector.dart';
import 'package:http/http.dart' as http;

class SectorRequest extends ChangeNotifier {
  final pb = PocketBase('http://${DB.dbIp}');
  List<Sector> listaSectores = [];

  Sector sectorParaAgregar = Sector(
    id: '',
    nombre: '',
    sucursal: '',
  );

  SectorRequest() {
    realTime();
    obtenerSectores();
    notifyListeners();
  }

  obtenerSectores() async {
    try {
      final response = await http.get(Uri.http(
          DB.dbIp, '/api/collections/sector/records', {
        'expand': 'sucursal',
        'sort': '-sucursal,-nombre',
        'perPage': '60'
      }));
      final data = SectorResponse.fromJson(response.body);
      listaSectores = data.items;
      // print("ejecutado0");
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  realTime() {
    try {
      final real = pb.collection('sector').subscribe('*', (e) {
        print(e);

        obtenerSectores();

        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  editSector(data) async {
    try {
      final reponse = await http.patch(
        Uri.http(DB.dbIp, '/api/collections/sector/records/${data.id}'),
        headers: {"Content-Type": "application/json"},
        body: data.toJson(),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  deleteSector(id) async {
    try {
      final response = await http.delete(
        Uri.http(DB.dbIp, '/api/collections/sector/records/$id'),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  agregarSector(Sector sector) async {
    try {
      final response = await http.post(
          Uri.http(DB.dbIp, "/api/collections/sector/records"),
          body: sector.toJson(),
          headers: {"Content-Type": "application/json"});
      limpiarSector();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  limpiarSector() {
    sectorParaAgregar = Sector(
      id: '',
      nombre: '',
      sucursal: '',
    );
  }
}
