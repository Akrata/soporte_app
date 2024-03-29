import 'dart:convert';

import 'package:soporte_app/models/sector.dart';
import 'package:soporte_app/models/toner.dart';

class Impresora {
  Impresora({
    this.collectionId,
    this.collectionName,
    this.created,
    this.expand,
    required this.id,
    required this.marca,
    required this.modelo,
    required this.ip,
    required this.sector,
    required this.toner,
    this.observaciones,
    this.updated,
  });

  String? collectionId;
  String? collectionName;
  DateTime? created;
  Expand? expand;
  String id;
  String marca;
  String modelo;
  String ip;
  String sector;
  String toner;
  String? observaciones;
  DateTime? updated;

  factory Impresora.fromJson(String str) => Impresora.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Impresora.fromMap(Map<String, dynamic> json) => Impresora(
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        expand: Expand.fromMap(json["expand"]),
        id: json["id"],
        marca: json["marca"],
        ip: json["ip"],
        modelo: json["modelo"],
        observaciones: json["observaciones"],
        sector: json["sector"],
        toner: json["toner"],
        updated: DateTime.parse(json["updated"]),
      );

  Map<String, dynamic> toMap() => {
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "expand": expand?.toMap(),
        "id": id,
        "marca": marca,
        "ip": ip,
        "modelo": modelo,
        "observaciones": observaciones,
        "sector": sector,
        "toner": toner,
        "updated": updated?.toIso8601String(),
      };
}

class Expand {
  Expand({
    this.sector,
    this.toner,
  });

  Sector? sector;
  Toner? toner;

  factory Expand.fromJson(String str) => Expand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Expand.fromMap(Map<String, dynamic> json) => Expand(
        sector: Sector.fromMap(json["sector"]),
        toner: Toner.fromMap(json["toner"]),
      );

  Map<String, dynamic> toMap() => {
        "sector": sector?.toMap(),
        "toner": toner?.toMap(),
      };
}
