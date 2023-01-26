import 'dart:convert';

import 'package:movil_huerta_nft/src/models/huerta_model.dart';

class Riegos {
  var items = <Riego>[];
  Riegos();

  Riegos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final riego = new Riego.fromJsonMap(item);
      items.add(riego);
    }
  }
}

Riego RiegoFromJson(String str) => Riego.fromJsonMap(json.decode(str));

String RiegoToJson(Riego data) => json.encode(data.toJson());

class Riego {
  dynamic idRiego;
  dynamic fechaFin;
  dynamic fechaInicio;
  bool repite;
  bool realizado;
  bool fallido;
  dynamic idHuerta;

  Riego({
    this.idRiego = '',
    this.fechaFin = '',
    this.fechaInicio = '',
    this.repite = true,
    this.realizado = false,
    this.fallido = false,
    this.idHuerta = '',
  });

  factory Riego.fromJsonMap(Map<String, dynamic> json) => Riego(
      idRiego: json["idRiego"],
      fechaFin: json["fechaFin"],
      fechaInicio: json["fechaInicio"],
      repite: json["repite"],
      realizado: json["realizado"],
      fallido: json["fallido"],
      idHuerta: json["idHuerta"]);

  Map<String, dynamic> toJson() => {
        "idRiego": idRiego,
        "fechaFin": fechaFin,
        "fechaInicio": fechaInicio,
        "repite": repite,
        "realizado": realizado,
        "fallido": fallido,
        "idHuerta": idHuerta
      };
}
