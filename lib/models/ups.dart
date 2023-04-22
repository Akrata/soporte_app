import 'dart:convert';

import 'item_expand.dart';

class Ups {
  Ups(
      {required this.id,
      this.collectionId,
      this.collectionName,
      this.created,
      this.updated,
      required this.marca,
      required this.modelo,
      this.descripcion,
      required this.sector,
      this.ultimoMantenimiento,
      this.expand});

  String id;
  String? collectionId;
  String? collectionName;
  DateTime? created;
  DateTime? updated;
  String marca;
  String modelo;
  String? descripcion;
  String sector;
  DateTime? ultimoMantenimiento;
  ItemExpand? expand;

  factory Ups.fromJson(String str) => Ups.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ups.fromMap(Map<String, dynamic> json) => Ups(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        marca: json["marca"],
        modelo: json["modelo"],
        descripcion: json["descripcion"],
        sector: json["sector"],
        ultimoMantenimiento: json["ultimo_mantenimiento"] == ''
            ? null
            : DateTime.parse(json["ultimo_mantenimiento"]),
        expand: ItemExpand.fromMap(json["expand"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "marca": marca,
        "modelo": modelo,
        "descripcion": descripcion,
        "sector": sector,
        "ultimo_mantenimiento": ultimoMantenimiento?.toIso8601String(),
        "expand": expand?.toMap(),
      };
}
