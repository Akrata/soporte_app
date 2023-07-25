// To parse this JSON data, do
//
//

import 'dart:convert';

import 'package:soporte_app/models/vpn.dart';

class VpnResponse {
  VpnResponse({
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
  List<VPN> items;

  factory VpnResponse.fromJson(String str) =>
      VpnResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VpnResponse.fromMap(Map<String, dynamic> json) => VpnResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items: List<VPN>.from(json["items"].map((x) => VPN.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
