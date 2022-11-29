// To parse this JSON data, do
//
//     final curier = curierFromJson(jsonString);

import 'dart:convert';

Curier curierFromJson(String str) => Curier.fromJson(json.decode(str));

String curierToJson(Curier data) => json.encode(data.toJson());

class Curier {
  Curier({
    this.code,
    this.name,
    this.costs,
  });

  String? code;
  String? name;
  List<CurierCost>? costs;

  factory Curier.fromJson(Map<String, dynamic> json) => Curier(
        code: json["code"],
        name: json["name"],
        costs: List<CurierCost>.from(
            json["costs"].map((x) => CurierCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs!.map((x) => x.toJson())),
      };

  static List<Curier> fromJsonList(List list) {
    if (list.length == 0) return List<Curier>.empty();
    return list.map((item) => Curier.fromJson(item)).toList();
  }
}

class CurierCost {
  CurierCost({
    this.service,
    this.description,
    this.cost,
  });

  String? service;
  String? description;
  List<CostCost>? cost;

  factory CurierCost.fromJson(Map<String, dynamic> json) => CurierCost(
        service: json["service"],
        description: json["description"],
        cost:
            List<CostCost>.from(json["cost"].map((x) => CostCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost!.map((x) => x.toJson())),
      };
}

class CostCost {
  CostCost({
    this.value,
    this.etd,
    this.note,
  });

  int? value;
  String? etd;
  String? note;

  factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}
