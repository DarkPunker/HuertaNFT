import 'package:flutter/material.dart';
import 'package:movil_huerta_nft/src/routes/routes.dart';
import 'package:movil_huerta_nft/src/services/riego_services.dart';
import 'package:movil_huerta_nft/src/shere_prefs/preferencias_usuario.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => RiegosService())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'login',
      routes: getApplicationRoutes(),
    );
  }
}
