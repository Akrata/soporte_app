import 'dart:convert';

class Notebook {
  String anio;
  String? collectionId;
  String? collectionName;
  DateTime? created;
  String id;
  String marca;
  String modelo;
  String? telefonoDeContacto;
  DateTime? updated;
  String? usuario;

  Notebook({
    required this.anio,
    this.collectionId,
    this.collectionName,
    this.created,
    required this.id,
    required this.marca,
    required this.modelo,
    this.telefonoDeContacto,
    this.updated,
    this.usuario,
  });

  factory Notebook.fromJson(String str) => Notebook.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notebook.fromMap(Map<String, dynamic> json) => Notebook(
        anio: json["anio"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        id: json["id"],
        marca: json["marca"],
        modelo: json["modelo"],
        telefonoDeContacto: json["telefono_de_contacto"],
        updated: DateTime.parse(json["updated"]),
        usuario: json["usuario"],
      );

  Map<String, dynamic> toMap() => {
        "anio": anio,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "id": id,
        "marca": marca,
        "modelo": modelo,
        "telefono": telefonoDeContacto ?? '',
        "updated": updated?.toIso8601String(),
        "usuario": usuario ?? '',
      };
}
