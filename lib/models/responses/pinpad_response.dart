// To parse this JSON data, do
//
//     final pinpadResponse = pinpadResponseFromMap(jsonString);

import 'dart:convert';

import 'package:soporte_app/models/pinpad.dart';

class PinpadResponse {
  PinpadResponse({
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
  List<Pinpad> items;

  factory PinpadResponse.fromJson(String str) =>
      PinpadResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PinpadResponse.fromMap(Map<String, dynamic> json) => PinpadResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items: List<Pinpad>.from(json["items"].map((x) => Pinpad.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
