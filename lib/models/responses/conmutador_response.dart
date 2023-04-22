// To parse this JSON data, do
//
//     final sectorResponse = sectorResponseFromMap(jsonString);

import 'dart:convert';

import 'package:soporte_app/models/conmutador.dart';
import 'package:soporte_app/models/sector.dart';

class ConmutadorResponse {
  ConmutadorResponse({
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
  List<Conmutador> items;

  factory ConmutadorResponse.fromJson(String str) =>
      ConmutadorResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConmutadorResponse.fromMap(Map<String, dynamic> json) =>
      ConmutadorResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items: List<Conmutador>.from(
            json["items"].map((x) => Conmutador.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
