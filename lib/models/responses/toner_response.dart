// To parse this JSON data, do
//
//     final tonerResponse = tonerResponseFromMap(jsonString);

import 'dart:convert';

import '../toner.dart';

class TonerResponse {
  TonerResponse({
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
  List<Toner> items;

  factory TonerResponse.fromJson(String str) =>
      TonerResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TonerResponse.fromMap(Map<String, dynamic> json) => TonerResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items: List<Toner>.from(json["items"].map((x) => Toner.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
