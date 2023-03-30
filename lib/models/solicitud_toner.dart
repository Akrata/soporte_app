import 'dart:convert';

import 'package:soporte_app/models/sector.dart';
import 'package:soporte_app/models/toner.dart';

class SolicitudToner {
  SolicitudToner({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.sector,
    required this.toner,
    required this.entregado,
    required this.expand,
    required this.responsable,
  });

  String id;
  String collectionId;
  String collectionName;
  DateTime created;
  DateTime updated;
  String sector;
  String toner;
  bool entregado;
  Expand expand;
  String responsable;

  factory SolicitudToner.fromJson(String str) =>
      SolicitudToner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SolicitudToner.fromMap(Map<String, dynamic> json) => SolicitudToner(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        sector: json["sector"],
        toner: json["toner"],
        entregado: json["entregado"],
        expand: Expand.fromMap(json["expand"]),
        responsable: json["responsable"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "sector": sector,
        "toner": toner,
        "entregado": entregado,
        "expand": expand.toMap(),
        "responsable": responsable,
      };
}

class Expand {
  Expand({
    required this.sector,
    required this.toner,
  });

  Sector sector;
  Toner toner;

  factory Expand.fromJson(String str) => Expand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Expand.fromMap(Map<String, dynamic> json) => Expand(
        sector: Sector.fromMap(json["sector"]),
        toner: Toner.fromMap(json["toner"]),
      );

  Map<String, dynamic> toMap() => {
        "sector": sector.toMap(),
        "toner": toner.toMap(),
      };
}
