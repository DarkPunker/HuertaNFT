import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movil_huerta_nft/src/models/huerta_model.dart';
import 'package:movil_huerta_nft/src/models/riego_model.dart';
import 'package:movil_huerta_nft/src/providers/http_complements.dart';

class RiegosProvider {
  Future<List<Riego>> getRiegos(Huerta huerta) async {
    var url = Uri.https(uri, getRiegosUrl(huerta.idHuerta), {'q': '{https}'});

    // Await the http get response, then decode the json-formatted response.
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    if (decodedData == null) return [];
    final riegos = new Riegos.fromJsonList(decodedData);
    return riegos.items;
  }

  Future<Map<String, dynamic>> eliminarRiego(String idRiego) async {
    var url = Uri.https(uri, setEliminarRiegoUrl(idRiego), {'q': '{https}'});
    final resp = await http.post(url, headers: headerContent(), body: []);

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('mensaje')) {
      return {
        'ok': true,
      };
    } else {
      return {'ok': false, 'error': decodedResp['mensaje']};
    }
  }
  

  Future<Map<String, dynamic>> registrarRiego(Riego riego) async {
    var url = Uri.https(uri, setCrearRiegoUrl(), {'q': '{https}'});
    final resp = await http.post(url,
        headers: headerContent(), body: RiegoToJson(riego));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('mensaje')) {
      return {
        'ok': true,
      };
    } else {
      return {'ok': false, 'error': decodedResp['mensaje']};
    }
  }
}
