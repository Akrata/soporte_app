// To parse this JSON data, do
//
//     final equipoResponse = equipoResponseFromMap(jsonString);

import 'dart:convert';

import '../equipo.dart';

class EquipoResponse {
  EquipoResponse({
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.totalItems,
    required this.items,
  });

  int page;
  int perPage;
  int totalPages;
  int totalItems;
  List<Equipo> items;

  factory EquipoResponse.fromJson(String str) =>
      EquipoResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EquipoResponse.fromMap(Map<String, dynamic> json) => EquipoResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items: List<Equipo>.from(json["items"].map((x) => Equipo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
