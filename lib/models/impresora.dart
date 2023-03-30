import 'dart:convert';

class Impresora {
  Impresora({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.marca,
    required this.modelo,
    required this.sector,
  });

  String id;
  String collectionId;
  String collectionName;
  DateTime created;
  DateTime updated;
  String marca;
  String modelo;
  String sector;

  factory Impresora.fromJson(String str) => Impresora.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Impresora.fromMap(Map<String, dynamic> json) => Impresora(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        marca: json["marca"],
        modelo: json["modelo"],
        sector: json["sector"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "marca": marca,
        "modelo": modelo,
        "sector": sector,
      };
}
