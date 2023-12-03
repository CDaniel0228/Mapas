import 'package:agroeconomicos/app_services.dart';
import 'package:agroeconomicos/asignar_ruta.dart';
import 'package:agroeconomicos/constantes.dart';
import 'package:agroeconomicos/seguiniento.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class ResponsiveNavBarPage extends StatefulWidget {
  const ResponsiveNavBarPage({Key? key}) : super(key: key);

  @override
  State<ResponsiveNavBarPage> createState() => _ResponsiveNavBarPage();
}

class _ResponsiveNavBarPage extends State<ResponsiveNavBarPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: principalGris,
          elevation: 0,
          titleSpacing: 0,
          leading: isLargeScreen
              ? null
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _menuItems[_selectedIndex],
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                if (isLargeScreen) Expanded(child: _navBarItems())
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: _ProfileIcon()),
            )
          ],
        ),
        drawer: isLargeScreen ? null : _drawer(),
        body: _pages.elementAt(_selectedIndex),
      ),
    );
  }

//movil
  Widget _drawer() => Drawer(
        backgroundColor: principalGris,
        child: ListView(
          children: _menuItems
              .map((item) => ListTile(
                    textColor: Colors.white,
                    onTap: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                      setState(() {
                        _selectedIndex = _menuItems.indexOf(item);
                      });
                    },
                    title: Text(item),
                  ))
              .toList(),
        ),
      );
//web
  Widget _navBarItems() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _menuItems
            .map(
              (item) => InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = _menuItems.indexOf(item);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
            .toList(),
      );
}

final List<String> _menuItems = <String>[
  'Home',
  'Asignar ruta',
  'Seguimiento',
  //'Desconectar',
];

final List<Widget> _pages = [
  const Home(),
  Ruta(),
  const Seguimiento()
  // const Sensores()
];

//enum Menu { itemOne, itemTwo, itemThree }

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.person,
        ),
        offset: const Offset(0, 40),
        onSelected: (value) {
          if (value.toString() == '/') {
            _mesageConfirmacion(context);
          } else {
            Navigator.pushNamed(context, value.toString());
          }
        },
        itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: '/perfil',
                child: Text('Cuenta'),
              ),
              const PopupMenuItem(
                value: '/',
                child: Text('Desconectar'),
              ),
            ]);
  }

  _mesageConfirmacion(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Se cerrará la sesión iniciada'),
          icon: const Icon(Icons.info_rounded),
          content: const Text('¿Deseas continuar?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () async {
                final appServices =
                    Provider.of<AppServices>(context, listen: false);
                appServices.logOut();
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        );
      },
    );
  }
}
