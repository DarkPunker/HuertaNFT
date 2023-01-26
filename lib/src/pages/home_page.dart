import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:movil_huerta_nft/src/pages/riegos_page.dart';
import 'package:movil_huerta_nft/src/shere_prefs/preferencias_usuario.dart';
import 'package:movil_huerta_nft/src/utils/utils.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final MqttServerClient client =
      MqttServerClient('a11w27fx47k9d5-ats.iot.sa-east-1.amazonaws.com', '');
  bool _isConnected = false;
  String error = "";
  StreamController<String> _messagesController = StreamController<String>();
  var porcentaje = 100.0;
  
  void initState() {
    super.initState();
    _setup();
  }

  _setup()  {
    try {
      //final directory = await getApplicationDocumentsDirectory();
      if (!_isConnected) {
        client.logging(on: true);
        client.keepAlivePeriod = 20;
        client.port = 8883;
        client.secure = true;
        final securityContext = SecurityContext.defaultContext;
        securityContext
            .setTrustedCertificates('assets/certificates/AmazonRootCA1.pem');
        securityContext
            .useCertificateChain('assets/certificates/certificate.pem.crt');
        securityContext.usePrivateKey(
          'assets/certificates/private.pem.key',
        );
        client.securityContext = securityContext;
        _conectar();
      }
    } catch (Exception) {
      _isConnected = false;
      error = "Error al Leer certificados ";
      print(Exception.toString());
    }
  }
  

  Future _conectar() async {
    if (!_isConnected) {
      try {
        await client.connect();
        if (client.connectionStatus!.state == MqttConnectionState.connected) {
          print("conexion al MQTT Exitosa");
          var sub = client.subscribe('sensor', MqttQos.atMostOnce);
          client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
            final MqttPublishMessage recMess =
                c[0].payload as MqttPublishMessage;
            final String message = MqttPublishPayload.bytesToStringAsString(
                recMess.payload.message);
            _messagesController.add(message);
          });
          _isConnected = true;
        }
      } catch (Exception) {
        _isConnected = false;
        error += "Error en la conexion al MQTT ";
      }
    }
    //return _isConnected;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isConnected) {
      print(error);
    }

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Riego NFT')),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: size.height * 0.08),
          _indicador(context),
          SizedBox(height: size.height * 0.15),
          _historial(context),
        ]),
      ),
    );
  }

  Widget bodySteam(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<String>(
      stream: _messagesController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          final List<String> values = snapshot.data.toString().split(",");
          final String dist = values[1].split(":")[1];
          var distancia = dist.split('"')[0];
          porcentaje = ((double.parse(UserPreferences.altura.toString()) -
                      double.parse(distancia)) /
                  double.parse(UserPreferences.altura.toString())) *
              100;
          return Container(
            padding: EdgeInsets.only(left: size.width * 0.08),
            child: Text(porcentaje.toStringAsFixed(2).toString() + " %"),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _historial(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RiegosPage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 1.5),
          ],
        ),
        height: size.height * 0.25,
        width: size.width * 0.45,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.02),
              imageCel(context),
              SizedBox(height: size.height * 0.03),
              Text("Historial"),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageCel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.15,
        width: size.width * 0.15,
        child: Column(
          children: <Widget>[
            circuloImage(context),
          ],
        ));
  }

  Widget circuloImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.blue),
      child: Image(
        image: AssetImage('assets/images/celHisto.jpeg'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget circulo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.blue),
      child: Container(
        padding: EdgeInsets.only(top: size.height * 0.06),
        child: bodySteam(context),
      ),
    );
  }

  Widget _indicador(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          showAlertInput(
              context, "Agregar Altura del Tanque (cm)", "Configuracion");
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 1.5),
            ],
          ),
          height: size.height * 0.25,
          width: size.width * 0.65,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.02),
                circulo(context),
                SizedBox(height: size.height * 0.03),
                Text("Nivel del Agua"),
              ],
            ),
          ),
        ));
  }
}
