import 'dart:convert';

import 'package:soporte_app/models/item_expand.dart';

class Telefono {
  Telefono({
    required this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    required this.nombre,
    required this.interno,
    required this.ip,
    required this.sector,
    this.observaciones,
    this.expand,
  });

  String id;
  String? collectionId;
  String? collectionName;
  DateTime? created;
  DateTime? updated;
  String nombre;
  String interno;
  String ip;
  String sector;
  String? observaciones;
  ItemExpand? expand;

  factory Telefono.fromJson(String str) => Telefono.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Telefono.fromMap(Map<String, dynamic> json) => Telefono(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        nombre: json["nombre"],
        interno: json["interno"],
        ip: json["ip"],
        sector: json["sector"],
        observaciones: json["observaciones"],
        expand: ItemExpand.fromMap(json["expand"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "nombre": nombre,
        "interno": interno,
        "ip": ip,
        "sector": sector,
        "observaciones": observaciones,
        "expand": expand?.toMap(),
      };
}
