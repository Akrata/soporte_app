import 'dart:convert';

import 'package:soporte_app/models/sucursal.dart';

class Sector {
  Sector(
      {required this.id,
      required this.collectionId,
      required this.collectionName,
      required this.created,
      required this.updated,
      required this.nombre,
      required this.sucursal,
      required this.expand});

  String id;
  String collectionId;
  String collectionName;
  DateTime created;
  DateTime updated;
  String nombre;
  Expand expand;
  String sucursal;

  factory Sector.fromJson(String str) => Sector.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sector.fromMap(Map<String, dynamic> json) => Sector(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        nombre: json["nombre"],
        sucursal: json["sucursal"],
        expand: Expand.fromMap(json["expand"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "nombre": nombre,
        "sucursal": sucursal,
      };
}

class Expand {
  Expand({
    required this.sucursal,
  });

  Sucursal sucursal;

  factory Expand.fromJson(String str) => Expand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Expand.fromMap(Map<String, dynamic> json) => Expand(
        sucursal: Sucursal.fromMap(json["sucursal"]),
      );

  Map<String, dynamic> toMap() => {
        "sucursal": sucursal.toMap(),
      };
}
