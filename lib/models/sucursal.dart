import 'dart:convert';

class Sucursal {
  Sucursal({
    required this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    required this.nombre,
  });

  String id;
  String? collectionId;
  String? collectionName;
  DateTime? created;
  DateTime? updated;
  String nombre;

  factory Sucursal.fromJson(String str) => Sucursal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sucursal.fromMap(Map<String, dynamic> json) => Sucursal(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "nombre": nombre,
      };
}
