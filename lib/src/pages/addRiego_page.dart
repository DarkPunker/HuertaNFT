import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:movil_huerta_nft/src/models/riego_model.dart';
import 'package:movil_huerta_nft/src/pages/riegos_page.dart';
import 'package:movil_huerta_nft/src/providers/riego_provider.dart';
import 'package:movil_huerta_nft/src/shere_prefs/preferencias_usuario.dart';
import 'package:movil_huerta_nft/src/utils/utils.dart';

class AgregarRiego extends StatefulWidget {
  @override
  _AgregarRiegoState createState() => _AgregarRiegoState();
}

class _AgregarRiegoState extends State<AgregarRiego> {
  Riego newRiego = Riego();

  final formKey = GlobalKey<FormState>();

  RiegosProvider riegosPr = new RiegosProvider();

  TextEditingController _date = TextEditingController();
  TextEditingController _dateH = TextEditingController();
  TextEditingController _dateHora = TextEditingController();
  TextEditingController _dateMinu = TextEditingController();
  TextEditingController _dateSegun = TextEditingController();

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text('Configurar Campos')),
        body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(children: <Widget>[
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text("Fecha inicio:"),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      _FechaInicio(context)
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text("Hora inicio:"),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      _HoraInicio(context)
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text("Tiempo de Riego:"),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      _horafield(context),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      _minutosfield(context),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      _segunfield(context),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text("Repite:"),
                      SizedBox(
                        width: size.width * 0.4,
                      ),
                      _repiteCheck(context)
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  _buttonCreation(context)
                ]))));
  }

  Widget _FechaInicio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.60,
      child: TextField(
        controller: _date,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          labelText: 'Fecha',
        ),
        onTap: () async {
          DateTime? pickeddate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100));
          if (pickeddate != null) {
            setState(() {
              _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
            });
          }
        },
      ),
    );
  }

  Widget _HoraInicio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.60,
      child: TextField(
        controller: _dateH,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          labelText: 'Hora',
        ),
        onTap: () async {
          TimeOfDay? pickedtime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());
          if (pickedtime != null) {
            setState(() {
              _dateH.text = pickedtime.format(context).toString();
              print(_dateH.text);
            });
          }
        },
      ),
    );
  }

  Widget _horafield(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.14,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          controller: _dateHora,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            labelText: 'HH',
          ),
        ));
  }

  Widget _minutosfield(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.14,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          controller: _dateMinu,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            labelText: 'MM',
          ),
        ));
  }

  Widget _segunfield(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.14,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          controller: _dateSegun,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            labelText: 'SS',
          ),
          onChanged: (value) => {_dateSegun.text = value, setState(() {})},
          validator: (value) {
            if (value.toString().length > 2) {
              return 'error';
            } else {
              return null;
            }
          },
        ));
  }

  Widget _repiteCheck(BuildContext context) {
    return Container(
        child: Checkbox(
      checkColor: Colors.white,
      //fillColor: MaterialStateProperty.resolveWith(getColor),
      value: newRiego.repite,
      onChanged: (bool? value) {
        setState(() {
          newRiego.repite = value!;
        });
      },
    ));
  }

  Widget _buttonCreation(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
            onPressed: () {
              _sumit();
            },
            child: const Text('Guardar', style: TextStyle(fontSize: 15))),
      ],
    );
  }

  void _sumit() async {
    if (formKey.currentState!.validate()) {
      bool validar = true;
      var responseRiego;
      if (_dateHora.text.toString().length < 1) validar = false;
      if (_dateMinu.text.toString().length < 1) validar = false;
      if (_dateSegun.text.toString().length < 1) validar = false;
      if (_dateH.text.toString().length < 1) validar = false;
      if (_date.text.toString().length < 1) validar = false;

      if (validar) {
        String datetostring =
            _date.text.toString() + ' ' + _dateH.text.toString();
        DateFormat format = DateFormat("yyyy-MM-dd hh:mm a");
        DateTime dateTime = format.parse(datetostring);
        String formattedDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

        Duration duration = Duration(
            hours: int.parse(_dateHora.text),
            minutes: int.parse(_dateMinu.text),
            seconds: int.parse(_dateSegun.text));
        DateTime dateTimeInit = DateTime.parse(formattedDate);
        DateTime dateTimeFin = dateTimeInit.add(duration);

        newRiego.fechaInicio =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTimeInit);
        newRiego.fechaFin =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTimeFin);

        newRiego.idHuerta = UserPreferences.idHuerta;

        responseRiego = await riegosPr.registrarRiego(newRiego);
        if (responseRiego['ok']) {
          //showAlert(context, "Registro Exitoso", "Informacion");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RiegosPage(),
            ),
          );
        } else {
          showAlert(context, responseRiego['error'], responseRiego['mensaje']);
        }
      } else {
        showAlert(context, "Todos los Datos son Obligatorios", "Informacion");
      }
    }
  }
}
