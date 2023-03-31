import 'dart:convert';

import 'package:soporte_app/models/sector.dart';
import 'package:soporte_app/models/toner.dart';

class Impresora {
  Impresora(
      {required this.id,
      required this.collectionId,
      required this.collectionName,
      required this.created,
      required this.updated,
      required this.marca,
      required this.modelo,
      required this.sector,
      required this.toner,
      required this.expand});

  String id;
  String collectionId;
  String collectionName;
  DateTime created;
  DateTime updated;
  String marca;
  String modelo;
  String sector;
  String toner;
  Expand expand;

  factory Impresora.fromJson(String str) => Impresora.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Impresora.fromMap(Map<String, dynamic> json) => Impresora(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        marca: json["marca"],
        modelo: json["modelo"],
        sector: json["sector"],
        toner: json["toner"],
        expand: Expand.fromMap(json["expand"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "marca": marca,
        "modelo": modelo,
        "sector": sector,
        "toner": toner,
        "expand": expand.toMap(),
      };
}

class Expand {
  Expand({
    required this.sector,
    required this.toner,
  });

  final Sector sector;
  final Toner toner;

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
