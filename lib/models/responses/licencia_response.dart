import 'dart:convert';

import '../licencia.dart';

class LicenciaResponse {
  int page;
  int perPage;
  int totalPages;
  int totalItems;
  List<Licencia> items;

  LicenciaResponse({
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.totalItems,
    required this.items,
  });

  factory LicenciaResponse.fromJson(String str) =>
      LicenciaResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LicenciaResponse.fromMap(Map<String, dynamic> json) =>
      LicenciaResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items:
            List<Licencia>.from(json["items"].map((x) => Licencia.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
