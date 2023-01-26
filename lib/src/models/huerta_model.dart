import 'dart:convert';

class Huertas {
  var items = <Huerta>[];
  Huertas();

  Huertas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final huerta = new Huerta.fromJsonMap(item);
      items.add(huerta);
    }
  }
}

Huerta huertaFromJson(String str) => Huerta.fromJsonMap(json.decode(str));

String huertaToJson(Huerta data) => json.encode(data.toJson());

class Huerta {
  dynamic idHuerta;
  bool estadoHuerta;
  
  Huerta({
    this.idHuerta = '',
    this.estadoHuerta = true,
  });

  factory Huerta.fromJsonMap(Map<String, dynamic> json) => Huerta(
        idHuerta: json["idHuerta"],
        estadoHuerta: json["estadoHuerta"]
      );

  Map<String, dynamic> toJson() => {
        "idHuerta": idHuerta,
        "estadoHuerta": estadoHuerta
      };
}