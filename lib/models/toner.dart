import 'dart:convert';

class Toner {
  Toner({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.modelo,
    required this.stockMovilPoliclinico,
    required this.stockFijoPoliclinico,
    required this.stockMovilSanatorio,
    required this.stockFijoSanatorio,
  });

  String id;
  String collectionId;
  String collectionName;
  DateTime created;
  DateTime updated;
  String modelo;
  int stockMovilPoliclinico;
  int stockFijoPoliclinico;
  String stockMovilSanatorio;
  String stockFijoSanatorio;

  factory Toner.fromJson(String str) => Toner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Toner.fromMap(Map<String, dynamic> json) => Toner(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        modelo: json["modelo"],
        stockMovilPoliclinico: json["stock_movil_policlinico"],
        stockFijoPoliclinico: json["stock_fijo_policlinico"],
        stockMovilSanatorio: json["stock_movil_sanatorio"],
        stockFijoSanatorio: json["stock_fijo_sanatorio"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "modelo": modelo,
        "stock_movil_policlinico": stockMovilPoliclinico,
        "stock_fijo_policlinico": stockFijoPoliclinico,
        "stock_movil_sanatorio": stockMovilSanatorio,
        "stock_fijo_sanatorio": stockFijoSanatorio,
      };
}
