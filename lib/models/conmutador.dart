import 'dart:convert';

import 'package:soporte_app/models/sucursal.dart';

class Conmutador {
  Conmutador(
      {required this.id,
      this.collectionId,
      this.collectionName,
      this.created,
      this.updated,
      required this.nombre,
      required this.ip,
      this.observaciones,
      required this.sucursal,
      this.expand});

  String id;
  String? collectionId;
  String? collectionName;
  DateTime? created;
  DateTime? updated;
  String nombre;
  String ip;
  String? observaciones;
  Expand? expand;
  String sucursal;

  factory Conmutador.fromJson(String str) =>
      Conmutador.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Conmutador.fromMap(Map<String, dynamic> json) => Conmutador(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        nombre: json["nombre"],
        ip: json["ip"],
        observaciones: json["observaciones"],
        sucursal: json["sucursal"],
        expand: Expand.fromMap(json["expand"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "nombre": nombre,
        "ip": ip,
        "observaciones": observaciones,
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
