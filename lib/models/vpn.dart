import 'dart:convert';

class VPN {
  String? collectionId;
  String? collectionName;
  DateTime? created;
  String id;
  String usuario;
  String password;
  String? nombreDeContacto;
  String? telefonoDeContacto;
  DateTime? updated;
  String? anydesk;

  VPN({
    this.collectionId,
    this.collectionName,
    this.created,
    required this.id,
    required this.usuario,
    required this.password,
    this.nombreDeContacto,
    this.telefonoDeContacto,
    this.updated,
    this.anydesk,
  });

  factory VPN.fromJson(String str) => VPN.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VPN.fromMap(Map<String, dynamic> json) => VPN(
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        id: json["id"],
        usuario: json["usuario"],
        password: json["password"],
        nombreDeContacto: json["nombre"],
        telefonoDeContacto: json["telefono"],
        updated: DateTime.parse(json["updated"]),
        anydesk: json["anydesk"],
      );

  Map<String, dynamic> toMap() => {
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "id": id,
        "usuario": usuario,
        "password": password,
        "nombre": nombreDeContacto ?? '',
        "telefono": telefonoDeContacto ?? '',
        "updated": updated?.toIso8601String(),
        "anydesk": anydesk ?? '',
      };
}
