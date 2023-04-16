import 'dart:convert';

import 'package:soporte_app/models/sector.dart';

class Equipo {
  Equipo({
    required this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    required this.nombre,
    required this.ip,
    required this.sector,
    this.ultimoMantenimiento,
    this.licenciaWindows,
    this.licenciaOffice,
    this.expand,
  });

  String id;
  String? collectionId;
  String? collectionName;
  DateTime? created;
  DateTime? updated;
  String nombre;
  String ip;
  String sector;
  DateTime? ultimoMantenimiento;
  String? licenciaWindows;
  String? licenciaOffice;
  ItemExpand? expand;

  factory Equipo.fromJson(String str) => Equipo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Equipo.fromMap(Map<String, dynamic> json) => Equipo(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        nombre: json["nombre"],
        ip: json["ip"],
        sector: json["sector"],
        ultimoMantenimiento: json["ultimo_mantenimiento"] == ""
            ? null
            : DateTime.parse(json["ultimo_mantenimiento"]),
        licenciaWindows: json["licencia_windows"],
        licenciaOffice: json["licencia_office"],
        expand: ItemExpand.fromMap(json["expand"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "nombre": nombre,
        "ip": ip,
        "sector": sector,
        "ultimo_mantenimiento": ultimoMantenimiento?.toIso8601String(),
        "licencia_windows": licenciaWindows,
        "licencia_office": licenciaOffice,
        "expand": expand?.toMap(),
      };
}

class ItemExpand {
  ItemExpand({
    required this.sector,
  });

  Sector sector;

  factory ItemExpand.fromJson(String str) =>
      ItemExpand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemExpand.fromMap(Map<String, dynamic> json) => ItemExpand(
        sector: Sector.fromMap(json["sector"]),
      );

  Map<String, dynamic> toMap() => {
        "sector": sector.toMap(),
      };
}
