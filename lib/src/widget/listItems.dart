import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movil_huerta_nft/src/models/riego_model.dart';
import 'package:movil_huerta_nft/src/providers/http_complements.dart';
import 'package:movil_huerta_nft/src/providers/riego_provider.dart';
import 'package:movil_huerta_nft/src/services/riego_services.dart';
import 'package:movil_huerta_nft/src/utils/utils.dart';

class ListItems extends StatelessWidget {
  final Riego riego;

  const ListItems({Key? key, required this.riego}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RiegosProvider riegosPr = new RiegosProvider();
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Container(
        margin: EdgeInsets.only(
          top: size.height * 0.02,
        ),
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black12),
        child: Row(
          children: <Widget>[
            SizedBox(width: size.width * 0.01),
            Text(riego.fechaInicio),
            SizedBox(width: size.width * 0.02),
            _estadoRiego(riego.realizado, riego.fallido),
            _espacio(context, riego.realizado, riego.fallido),
            //_buttonEdit(context, riego.realizado, riego.fallido),
            SizedBox(width: size.width * 0.01),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.trash),
              onPressed: () {
                riegosPr.eliminarRiego(riego.idRiego);
                showAlert(context, "Riego Eliminado", "Alerta");
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget _espacio(BuildContext context, bool relizado, bool fallido) {
  final size = MediaQuery.of(context).size;
  if(!relizado && fallido) return SizedBox(width: 42);
  return SizedBox(width: 11);
}

Widget _estadoRiego(bool relizado, bool fallido) {
  String text = '';
  if(!relizado && fallido) text = "Fallo";
  if(relizado && !fallido) text = "Realizado";
  if(!relizado && !fallido) text = "Pendiente";
  return Text(text);
}

Widget _buttonEdit(BuildContext context, bool relizado, bool fallido) {
  final size = MediaQuery.of(context).size;
  if (!relizado && !fallido) {
    return IconButton(icon: FaIcon(FontAwesomeIcons.pen), onPressed: () {});
  } else {
    return SizedBox(width: size.width * 0.05);
  }
}
