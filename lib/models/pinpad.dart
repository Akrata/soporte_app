import 'dart:convert';

class Pinpad {
  Pinpad({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.ip,
    required this.equipo,
  });

  String id;
  String collectionId;
  String collectionName;
  DateTime created;
  DateTime updated;
  String ip;
  String equipo;

  factory Pinpad.fromJson(String str) => Pinpad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pinpad.fromMap(Map<String, dynamic> json) => Pinpad(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        ip: json["ip"],
        equipo: json["equipo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "ip": ip,
        "equipo": equipo,
      };
}
