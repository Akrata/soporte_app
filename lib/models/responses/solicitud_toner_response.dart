// To parse this JSON data, do
//
//     final solicitudTonerResponse = solicitudTonerResponseFromMap(jsonString);

import 'dart:convert';

import 'package:soporte_app/models/sector.dart';
import 'package:soporte_app/models/solicitud_toner.dart';
import 'package:soporte_app/models/toner.dart';

class SolicitudTonerResponse {
  SolicitudTonerResponse({
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

  List<SolicitudToner> items;

  factory SolicitudTonerResponse.fromJson(String str) =>
      SolicitudTonerResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SolicitudTonerResponse.fromMap(Map<String, dynamic> json) =>
      SolicitudTonerResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items: List<SolicitudToner>.from(
            json["items"].map((x) => SolicitudToner.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
