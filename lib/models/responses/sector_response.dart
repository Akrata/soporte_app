// To parse this JSON data, do
//
//     final sectorResponse = sectorResponseFromMap(jsonString);

import 'dart:convert';

import 'package:soporte_app/models/sector.dart';

class SectorResponse {
  SectorResponse({
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
  List<Sector> items;

  factory SectorResponse.fromJson(String str) =>
      SectorResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SectorResponse.fromMap(Map<String, dynamic> json) => SectorResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items: List<Sector>.from(json["items"].map((x) => Sector.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
