import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movil_huerta_nft/src/models/huerta_model.dart';
import 'package:movil_huerta_nft/src/providers/http_complements.dart';
import 'package:mqtt_client/mqtt_client.dart';

class HuertasProvider {
  Future<List<Huerta>> getHuerta(Huerta huerta) async {
    var url =
      Uri.https(uri, getHuertaUrl(huerta.idHuerta) , {'q': '{https}'});

  // Await the http get response, then decode the json-formatted response.
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    if (decodedData == null) return [];
    final huertas = new Huertas.fromJsonList(decodedData);
    return huertas.items;
  }

  Future conectarmqtt(MqttClient client) async {
    await client.connect();
  }
}