import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movil_huerta_nft/src/models/huerta_model.dart';
import 'package:movil_huerta_nft/src/models/riego_model.dart';
import 'package:movil_huerta_nft/src/pages/addRiego_page.dart';
import 'package:movil_huerta_nft/src/pages/home_page.dart';
import 'package:movil_huerta_nft/src/providers/riego_provider.dart';
import 'package:movil_huerta_nft/src/services/riego_services.dart';
import 'package:movil_huerta_nft/src/widget/ListItems.dart';
import 'package:movil_huerta_nft/src/widget/loading_screen.dart';
import 'package:provider/provider.dart';

class RiegosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final riegosService = Provider.of<RiegosService>(context);

    if(riegosService.isLoading)return LoadingScreen();

    RiegosProvider riegosPr = new RiegosProvider();

    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text('Historial')),
        body: ListView.builder(
            itemCount: riegosService.riegosList.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                  child: ListItems(
                    riego: riegosService.riegosList[index],
                  ),
                )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                riegosService.loadRiegos();
              },
              heroTag: null,
              child: FaIcon(FontAwesomeIcons.refresh),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgregarRiego(),
                  ),
                );
              },
              heroTag: null,
              child: FaIcon(FontAwesomeIcons.plus),
            ),
          ],
        ));
  }
}
