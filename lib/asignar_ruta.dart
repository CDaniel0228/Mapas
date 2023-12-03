import 'package:flutter/material.dart';

import 'constantes.dart';

class Ruta extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Ruta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/perfil.jpg')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: Center(
            child: Card(
              color: Colors.white,
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 350),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _gap(),
                      TextFormField(
                        validator: (value) {
                          // add email validation
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          iconColor: Colors.amber,
                          labelText: 'Mapa',
                          hintText: 'Digite la ruta del mapa',
                          prefixIcon: Icon(Icons.map),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      TextFormField(
                        validator: (value) {
                          // add email validation
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          iconColor: Colors.amber,
                          labelText: 'Telefono',
                          hintText: 'Digite su numero telefonico',
                          prefixIcon: Icon(Icons.call),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      TextFormField(
                        validator: (value) {
                          // add email validation
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          iconColor: Colors.amber,
                          labelText: 'Vehiculo',
                          hintText: 'Digite su tipo de vehiculo',
                          prefixIcon: Icon(Icons.car_repair),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      TextFormField(
                        validator: (value) {
                          // add email validation
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          iconColor: Colors.amber,
                          labelText: 'Encuentro',
                          hintText: 'Digite el lugar',
                          prefixIcon: Icon(Icons.place),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      TextFormField(
                        validator: (value) {
                          // add email validation
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          iconColor: Colors.amber,
                          labelText: 'Estado',
                          hintText: 'El vehiculo esta disponible',
                          prefixIcon: Icon(Icons.commute_sharp),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: principalVerde,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Iniciar ruta',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.pushNamed(context, '/home');
                            }
                            Navigator.pushNamed(context, '/home');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget _gap() => const SizedBox(height: 16);
}
