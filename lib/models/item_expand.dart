import 'dart:convert';

import 'package:soporte_app/models/sector.dart';

class ItemExpand {
  ItemExpand({
    required this.sector,
  });

  Sector sector;

  factory ItemExpand.fromJson(String str) =>
      ItemExpand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemExpand.fromMap(Map<String, dynamic> json) => ItemExpand(
        sector: Sector.fromMap(json["sector"]),
      );

  Map<String, dynamic> toMap() => {
        "sector": sector.toMap(),
      };
}
