import 'dart:convert';

import 'item_expand.dart';

class Pinpad {
  Pinpad(
      {required this.id,
      this.collectionId,
      this.collectionName,
      this.created,
      this.updated,
      required this.ip,
      this.observaciones,
      required this.sector,
      this.expand});

  String id;
  String? collectionId;
  String? collectionName;
  DateTime? created;
  DateTime? updated;
  String ip;
  String? observaciones;
  String sector;
  ItemExpand? expand;

  factory Pinpad.fromJson(String str) => Pinpad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pinpad.fromMap(Map<String, dynamic> json) => Pinpad(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        ip: json["ip"],
        observaciones: json["observaciones"],
        sector: json["sector"],
        expand: ItemExpand.fromMap(json["expand"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "ip": ip,
        "observaciones": observaciones,
        "sector": sector,
        "expand": expand?.toMap(),
      };
}
