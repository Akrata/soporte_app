import 'dart:convert';

class Equipo {
  Equipo({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.nombre,
    required this.ip,
    required this.sector,
    required this.ultimoMantenimiento,
    required this.licenciaWindows,
    required this.licenciaOffice,
  });

  String id;
  String collectionId;
  String collectionName;
  DateTime created;
  DateTime updated;
  String nombre;
  String ip;
  String sector;
  DateTime ultimoMantenimiento;
  String licenciaWindows;
  String licenciaOffice;

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
        ultimoMantenimiento: DateTime.parse(json["ultimo_mantenimiento"]),
        licenciaWindows: json["licencia_windows"],
        licenciaOffice: json["licencia_office"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "nombre": nombre,
        "ip": ip,
        "sector": sector,
        "ultimo_mantenimiento": ultimoMantenimiento.toIso8601String(),
        "licencia_windows": licenciaWindows,
        "licencia_office": licenciaOffice,
      };
}
