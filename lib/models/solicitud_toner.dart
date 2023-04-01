import 'dart:convert';

import 'package:soporte_app/models/sector.dart';
import 'package:soporte_app/models/toner.dart';
import 'package:soporte_app/models/users.dart';

class SolicitudToner {
  SolicitudToner({
    this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    required this.sector,
    required this.toner,
    this.entregado,
    this.expand,
    this.users,
  });

  String? id;
  String? collectionId;
  String? collectionName;
  DateTime? created;
  DateTime? updated;
  String sector;
  String toner;
  bool? entregado;
  Expand? expand;
  String? users;

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
        users: json["users"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "sector": sector,
        "toner": toner,
        "entregado": entregado,
        "expand": expand?.toMap(),
        "users": users,
      };
}

class Expand {
  Expand({
    required this.sector,
    required this.toner,
    this.users,
  });

  final Sector sector;
  final Toner toner;
  final Users? users;

  factory Expand.fromJson(String str) => Expand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Expand.fromMap(Map<String, dynamic> json) => Expand(
        sector: Sector.fromMap(json["sector"]),
        toner: Toner.fromMap(json["toner"]),
        users: json["users"] == null ? null : Users.fromMap(json["users"]),
      );

  Map<String, dynamic> toMap() => {
        "sector": sector.toMap(),
        "toner": toner.toMap(),
        "users": users?.toMap(),
      };
}
