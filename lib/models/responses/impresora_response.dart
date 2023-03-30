// To parse this JSON data, do
//
//     final impresoraResponse = impresoraResponseFromMap(jsonString);

import 'dart:convert';

import 'package:soporte_app/models/impresora.dart';

class ImpresoraResponse {
  ImpresoraResponse({
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
  List<Impresora> items;

  factory ImpresoraResponse.fromJson(String str) =>
      ImpresoraResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImpresoraResponse.fromMap(Map<String, dynamic> json) =>
      ImpresoraResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items: List<Impresora>.from(
            json["items"].map((x) => Impresora.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
