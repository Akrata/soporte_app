// To parse this JSON data, do
//
//     final sucursalResponse = sucursalResponseFromMap(jsonString);

import 'dart:convert';

import '../sucursal.dart';

class SucursalResponse {
  SucursalResponse({
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
  List<Sucursal> items;

  factory SucursalResponse.fromJson(String str) =>
      SucursalResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SucursalResponse.fromMap(Map<String, dynamic> json) =>
      SucursalResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items:
            List<Sucursal>.from(json["items"].map((x) => Sucursal.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
