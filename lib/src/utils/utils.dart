import 'package:flutter/material.dart';
import 'package:movil_huerta_nft/src/shere_prefs/preferencias_usuario.dart';

void showAlert(BuildContext context, String message, String title) {
  showDialog(
      context: context,
      builder: (context) {
        return _buildAlertDialog(context, message, title);
      });
}

Widget _buildAlertDialog(BuildContext context, String message, String title) {
    return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
}
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//                 onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
//           ],
//         );
//       });
// }

void showAlertInput(BuildContext context, String message, String title) {
  final size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            height: size.height * 0.18,
            child: Column(children: [
              Text(message),
              SizedBox(height: size.height * 0.02,),
              TextFormField(
                initialValue: UserPreferences.altura.toString(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  labelText: 'Altura',
                ),
                onChanged: (value) => {
                  UserPreferences.altura = value,
                },
              ),
            ]),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}
