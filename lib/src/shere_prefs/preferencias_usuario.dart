
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _prefs;

  static dynamic _idHuerta = '';
  static dynamic _altura = 0;

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  static dynamic get idHuerta{
    return _prefs.getString('idHuerta') ?? _idHuerta;
  }

  static dynamic get altura{
    return _prefs.getString('altura') ?? _altura;
  }

  static set altura (dynamic altura)
  {
    _altura = altura;
    _prefs.setString('altura', altura);
  }

  static set idHuerta (dynamic idHuerta)
  {
    _idHuerta = idHuerta;
    _prefs.setString('idHuerta', idHuerta);
  }
}
