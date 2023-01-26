import 'package:flutter/material.dart';
import 'package:movil_huerta_nft/src/models/huerta_model.dart';
import 'package:movil_huerta_nft/src/pages/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movil_huerta_nft/src/providers/huertas_provider.dart';
import 'package:movil_huerta_nft/src/shere_prefs/preferencias_usuario.dart';
import 'package:movil_huerta_nft/src/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _NewRiegoState createState() => _NewRiegoState();

}

class _NewRiegoState extends State<LoginPage> {

 final formKey = GlobalKey<FormState>();
 HuertasProvider huertaPr = new HuertasProvider();

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
              child: Form(
                key: formKey,
        child: Column(
          children: <Widget>[
            _image(context),
            SizedBox(height: size.height * 0.05),
            _textTitulo(context),
            SizedBox(height: size.height * 0.05),
            _textDescripcion(context),
            SizedBox(height: size.height * 0.15),
            _huertaName(context),
            SizedBox(height: size.height * 0.10),
            _buttonCreation(context),
          ],
        ),
      ))),
    );
  }

  Widget _textTitulo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      child: Text(
        "Riego NFT",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _textDescripcion(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      child: Text(
        "La manera simple de controlar los tiempos de circulacion en tu cultivo",
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _image(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.06),
      height: size.height * 0.3,
      child: Image(
        image: AssetImage('assets/images/huerta.jpeg'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _huertaName(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      child: TextFormField(
        initialValue: UserPreferences.idHuerta,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          labelText: 'Nombre de Huerta',
        ),
        onChanged: (value) =>
        {
          UserPreferences.idHuerta = value,
          setState(() {})
        },
        validator: (value) {
          if (value.toString().length < 1) {
            return 'Ingrese Nombre';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _buttonCreation(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
            onPressed: () {
              _sumit();
            },
            child: const Text('Iniciar', style: TextStyle(fontSize: 15))),
      ],
    );
  }

  void _sumit() async {
    if( formKey.currentState!.validate() )
    {
      Huerta huerta = new Huerta(idHuerta: UserPreferences.idHuerta);
      var secHuerta = await huertaPr.getHuerta(huerta);
      if(secHuerta.length < 1)
      {
        showAlert(context, "Huerta no existente", "Alerta");
        
      }else{
        print(secHuerta[0].idHuerta.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }

    }

  }
}
