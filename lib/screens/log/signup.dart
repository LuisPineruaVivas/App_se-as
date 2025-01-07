import 'package:first_app/screens/log/controller/signup_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:first_app/screens/log/login.dart';
import 'package:first_app/components/scaffold_home.dart';
import 'package:flutter/scheduler.dart';
import '../home/home.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/signup";
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _con = SignUpController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timestamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldHome(
      image: 'images/registro.png',
      child: Column(
        children: [
          const Expanded(
            flex: 3,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _con.formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Registro',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.lightBlue,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          _con.nombre.text = value;
                        },
                        validator: (value) {
                          String pattern = r'^[a-zA-Z\s]*$';
                          RegExp regex = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese nombre completo';
                          } else if (!regex.hasMatch(value)) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Solo se permiten letras y espacios en el nombre'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            return 'Solo se permiten letras y espacios en el nombre';
                          }
                          return null;
                        },
                        controller: _con.nombre,
                        decoration: InputDecoration(
                          label: const Text('Nombre'),
                          hintText: 'Ingrese nombre completo',
                          prefixIcon: const Icon(Icons.person),
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        onFieldSubmitted: (value) {
                          String pattern = r'^.+@(gmail\.com|hotmail\.com)$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Por favor ingrese un correo que termine en @gmail.com o @hotmail.com'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _con.correo,
                        decoration: InputDecoration(
                          labelText: 'Correo',
                          hintText: 'Ingrese el correo',
                          prefixIcon: const Icon(Icons.email),
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          _con.contrasena.text = value;
                        },
                        obscureText: _con.obscureText,
                        obscuringCharacter: '*',
                        validator: (value) {
                          String pattern = r'^(?=.*[A-Z])(?=.*\d).{6,}$';
                          RegExp regex = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese una contraseña';
                          } else if (!regex.hasMatch(value)) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'La contraseña debe tener al menos 6 caracteres, incluir una letra mayúscula y un número'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            return 'La contraseña debe tener al menos 6 caracteres, incluir una letra mayúscula y un número';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Contraseña'),
                          hintText: 'Ingrese una contraseña',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _con.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              _con.contrasenavisible();
                            },
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_con.formSignupKey.currentState?.validate() ??
                                false) {
                              try {
                                final result = await _con.user
                                    .fetchSignInMethodsForEmail(
                                        _con.correo.text);

                                if (result.isNotEmpty) {
                                  _con.mostrarDialogCorreoExistente();
                                } else {
                                  _con.formSignupKey.currentState!.save();
                                  _con.register().then(
                                    (value) {
                                      _mostrarAlertaRegistroExitoso();
                                    },
                                  );
                                }
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue),
                          child: const Text(
                            'Registrarse',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Ya tienes cuenta? ',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Inicia Sesion',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  void _mostrarAlertaRegistroExitoso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro Exitoso'),
          content: const Text(
              'Por favor, es importante tener presente que al momento de registrar tu dirección de correo electrónico, en caso de que ésta no exista, no será factible acceder al enlace de recuperación que será enviado a dicha dirección de correo electrónico ingresada.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
          ],
        );
      },
    );
  }
}
