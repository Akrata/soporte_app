// To parse this JSON data, do
//
//     final pinpadResponse = pinpadResponseFromMap(jsonString);

import 'dart:convert';

import 'package:soporte_app/models/notebook.dart';

class NotebookResponse {
  NotebookResponse({
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
  List<Notebook> items;

  factory NotebookResponse.fromJson(String str) =>
      NotebookResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotebookResponse.fromMap(Map<String, dynamic> json) =>
      NotebookResponse(
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
        items:
            List<Notebook>.from(json["items"].map((x) => Notebook.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
