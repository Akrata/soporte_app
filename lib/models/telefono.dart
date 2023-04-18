import 'dart:convert';

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
  });

  String id;
  String? collectionId;
  String? collectionName;
  DateTime? created;
  DateTime? updated;
  String nombre;
  int interno;
  String ip;
  String sector;

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
      };
}
