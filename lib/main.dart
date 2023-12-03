import 'package:agroeconomicos/inicio_sesion.dart';
import 'package:agroeconomicos/perfil.dart';
import 'package:agroeconomicos/registrar_usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'app_services.dart';
import 'menu_navegacion.dart';
import 'realm_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Config realmConfig = await Config.getConfig('assets/atlasConfig.json');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Config>(create: (_) => realmConfig),
    ChangeNotifierProvider<AppServices>(
        create: (_) => AppServices(realmConfig.appId, realmConfig.baseUrl)),
    ChangeNotifierProxyProvider<AppServices, RealmServices?>(
        create: (context) => null,
        update: (BuildContext context, AppServices appServices,
            RealmServices? realmServices) {
          return appServices.app.currentUser != null
              ? RealmServices(appServices.app)
              : null;
        }),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String atlasUrl =
        Provider.of<Config>(context, listen: false).atlasUrl;
    print("To see your data in Atlas, follow this link:$atlasUrl");

    final currentUser =
        Provider.of<RealmServices?>(context, listen: false)?.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: currentUser != null ? '/' : '/home',
      routes: {
        '/': (context) => const SignInPage1(),
        '/home': (context) => const ResponsiveNavBarPage(),
        '/perfil': (context) => ProfilePage1(),
        '/registrar': (context) => const Registrar(),
      },
    );
  }
}

class Config extends ChangeNotifier {
  late String appId;
  late String atlasUrl;
  late Uri baseUrl;

  Config._create(dynamic realmConfig) {
    appId = realmConfig['appId'];
    atlasUrl = realmConfig['dataExplorerLink'];
    baseUrl = Uri.parse(realmConfig['baseUrl']);
  }

  static Future<Config> getConfig(String jsonConfigPath) async {
    dynamic realmConfig =
        json.decode(await rootBundle.loadString(jsonConfigPath));

    var config = Config._create(realmConfig);

    return config;
  }
}
