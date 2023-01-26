import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movil_huerta_nft/src/models/riego_model.dart';
import 'package:movil_huerta_nft/src/providers/http_complements.dart';
import 'package:movil_huerta_nft/src/shere_prefs/preferencias_usuario.dart';

class RiegosService extends ChangeNotifier {
  final String _baseURL = uri;
  List<Riego> riegosList= [];
  bool isLoading = true;

  RiegosService() {
    this.loadRiegos();
  }

  Future<List<Riego>> loadRiegos() async {
    this.isLoading = true;
    notifyListeners();

    var url = Uri.https(
        uri, getRiegosUrl(UserPreferences.idHuerta), {'q': '{https}'});

    // Await the http get response, then decode the json-formatted response.
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    if (decodedData == null) return [];
    final riegos = new Riegos.fromJsonList(decodedData);
    this.isLoading = false;
    notifyListeners();
    this.riegosList = riegos.items;
    return riegosList;
  }
  
}
