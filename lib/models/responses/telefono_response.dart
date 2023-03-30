// To parse this JSON data, do
//
//     final telefonoResponse = telefonoResponseFromMap(jsonString);

import 'dart:convert';

import 'package:soporte_app/models/telefono.dart';

class TelefonoResponse {
  TelefonoResponse({
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
  List<Telefono> items;

  factory TelefonoResponse.fromJson(String str) =>
      TelefonoResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TelefonoResponse.fromMap(Map<String, dynamic> json) =>
      TelefonoResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items:
            List<Telefono>.from(json["items"].map((x) => Telefono.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
