import 'package:agroeconomicos/constantes.dart';
import 'package:agroeconomicos/realm_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_services.dart';

class Registrar extends StatefulWidget {
  const Registrar({Key? key}) : super(key: key);

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  bool _isPasswordVisible = false;
  bool _isPasswordVisible2 = false;
  TextEditingController correo = TextEditingController();
  TextEditingController nombres = TextEditingController();
  TextEditingController usuario = TextEditingController();
  TextEditingController contrasenia = TextEditingController();
  TextEditingController confirmar = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.light(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: principalNaranja,
          ),
          body: Form(
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
                        Text(
                          "REGISTRARME",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        _gap(),
                        TextFormField(
                          controller: correo,
                          validator: (value) {
                            // add email validation
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }

                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if (!emailValid) {
                              return 'Please enter a valid email';
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        _gap(),
                        TextFormField(
                          controller: nombres,
                          validator: (value) {
                            // add email validation
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Nombre completo',
                            hintText: 'Digite su nombre',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        _gap(),
                        TextFormField(
                          controller: usuario,
                          validator: (value) {
                            // add email validation
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Usuario',
                            hintText: 'Digite un nombre de usuario',
                            prefixIcon: Icon(Icons.person_4_rounded),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        _gap(),
                        TextFormField(
                          controller: contrasenia,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }

                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                              labelText: 'Contraseña',
                              hintText: 'Digite su contraseña',
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(_isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              )),
                        ),
                        _gap(),
                        TextFormField(
                          controller: confirmar,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }

                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          obscureText: !_isPasswordVisible2,
                          decoration: InputDecoration(
                              labelText: 'Repetir contraseña',
                              hintText: 'Digite su contraseña',
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(_isPasswordVisible2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible2 = !_isPasswordVisible2;
                                  });
                                },
                              )),
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
                                'Crear cuenta',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final appServices = Provider.of<AppServices>(
                                    context,
                                    listen: false);
                                if (contrasenia.text == confirmar.text) {
                                  await appServices.registerUserEmailPassword(
                                      correo.text, contrasenia.text);
                                  RealmServices(appServices.app)
                                      .createItem(nombres.text, usuario.text);
                                  Navigator.pushNamed(context, '/home');
                                  correo.text = '';
                                  nombres.text = '';
                                  usuario.text = '';
                                  contrasenia.text = '';
                                  confirmar.text = '';
                                } else {
                                  //Mensaje
                                }
                              }
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
        ));
  }

  Widget _gap() => const SizedBox(height: 16);
}
