import 'dart:convert';

import 'equipo.dart';

class Licencia {
  String? collectionId;
  String? collectionName;
  DateTime? created;
  String? equipo;
  Expand? expand;
  String id;
  String key;
  String tipo;
  DateTime? updated;

  Licencia({
    this.collectionId,
    this.collectionName,
    this.created,
    this.equipo,
    this.expand,
    required this.id,
    required this.key,
    required this.tipo,
    this.updated,
  });

  factory Licencia.fromJson(String str) => Licencia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Licencia.fromMap(Map<String, dynamic> json) => Licencia(
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        equipo: json["equipo"],
        expand: Expand.fromMap(json["expand"]),
        id: json["id"],
        key: json["key"],
        tipo: json["tipo"],
        updated: DateTime.parse(json["updated"]),
      );

  Map<String, dynamic> toMap() => {
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "equipo": equipo,
        "expand": expand?.toMap(),
        "id": id,
        "key": key,
        "tipo": tipo,
        "updated": updated?.toIso8601String(),
      };
}

class Expand {
  Equipo equipo;

  Expand({
    required this.equipo,
  });

  factory Expand.fromJson(String str) => Expand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Expand.fromMap(Map<String, dynamic> json) => Expand(
        equipo: Equipo.fromMap(json["equipo"]),
      );

  Map<String, dynamic> toMap() => {
        "equipo": equipo.toMap(),
      };
}
