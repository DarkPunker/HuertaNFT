import 'package:flutter/material.dart';
import 'package:movil_huerta_nft/src/pages/addRiego_page.dart';

import 'package:movil_huerta_nft/src/pages/home_page.dart';
import 'package:movil_huerta_nft/src/pages/login.dart';
import 'package:movil_huerta_nft/src/pages/riegos_page.dart';
//import 'package:movil/src/pages/branch.dart';
//import 'package:movil/src/pages/home_page.dart';
//import 'package:movil/src/pages/menu_page.dart';
//import 'package:movil/src/pages/new_product.dart';
//import 'package:movil/src/pages/products.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'riegos': (BuildContext context) => RiegosPage(),
    'nuevoRiegos': (BuildContext context) => AgregarRiego()

    // '/' : (BuildContext context) => HomePage(),
    // 'MenuPage' : (BuildContext context) => MenuPage(),
    // 'Product' : (BuildContext context) => ProductsPage(),
    // 'NewProduct' : (BuildContext context) => NewProduct(),
    // 'NewBranch' : (BuildContext context) => BranchOfficesPage(),

    // 'Inventory' : (BuildContext context) => InventoryPage(),
    // 'Invoice' : (BuildContext context) => InvoicePage(),
    // 'Branch' : (BuildContext context) => BranchPage(),
    // 'EditInvetory': (BuildContext context) => EditInvetory(),
  };
}
