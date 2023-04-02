import 'dart:convert';

class Users {
  Users({
    required this.avatar,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.emailVisibility,
    required this.id,
    required this.name,
    required this.updated,
    required this.username,
    required this.verified,
    required this.lugarTrabajo,
  });

  final String avatar;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final bool emailVisibility;
  final String id;
  final String name;
  final DateTime updated;
  final String username;
  final bool verified;
  final String lugarTrabajo;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Users.fromMap(Map<String, dynamic> json) => Users(
      avatar: json["avatar"],
      collectionId: json["collectionId"],
      collectionName: json["collectionName"],
      created: DateTime.parse(json["created"]),
      emailVisibility: json["emailVisibility"],
      id: json["id"],
      name: json["name"],
      updated: DateTime.parse(json["updated"]),
      username: json["username"],
      verified: json["verified"],
      lugarTrabajo: json["lugarTrabajo"]);

  Map<String, dynamic> toMap() => {
        "avatar": avatar,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "emailVisibility": emailVisibility,
        "id": id,
        "name": name,
        "updated": updated.toIso8601String(),
        "username": username,
        "verified": verified,
        "lugarTrabajo": lugarTrabajo,
      };
}
