// To parse this JSON data, do
//
//     final upsResponse = upsResponseFromMap(jsonString);

import 'dart:convert';

import 'package:soporte_app/models/ups.dart';

class UpsResponse {
  UpsResponse({
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
  List<Ups> items;

  factory UpsResponse.fromJson(String str) =>
      UpsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpsResponse.fromMap(Map<String, dynamic> json) => UpsResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items: List<Ups>.from(json["items"].map((x) => Ups.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
