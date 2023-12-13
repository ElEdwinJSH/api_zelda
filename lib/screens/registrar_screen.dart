import 'package:api_zelda/widgets/video_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:api_zelda/providers/login_form_provider.dart';
//import 'package:api_zelda/screens/login_screen.dart';
import 'package:api_zelda/services/services.dart';
import 'package:provider/provider.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        VideoWidget(),
        SimpleDialog(
          backgroundColor: Color.fromARGB(255, 32, 63, 97).withOpacity(0.4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          title: const Center(
            child: Text(
              'Crear cuenta',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          children: [
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          ChangeNotifierProvider(
                              create: (_) => LoginFormProvider(),
                              child: const _Registrar())
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ],
    ));
  }
}

class _Registrar extends StatelessWidget {
  const _Registrar({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //qui decia <widget>

            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'user@example.com',
                  labelText: 'Correo electrónico',
                  labelStyle: TextStyle(color: Colors.white70),
                  hintStyle: TextStyle(color: Colors.white30),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  errorStyle: TextStyle(color: Colors.orange),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El valor ingresado no luce como un correo';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Colors.white70),
                  hintStyle: TextStyle(color: Colors.white30),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  errorStyle: TextStyle(color: Colors.orange),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                ),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  return (value != null && value.length >= 6)
                      ? null
                      : 'La contraseña debe de ser de 6 caracteres';
                },
              ),
            ),
            ElevatedButton(
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      // TODO: validar si el login es correcto
                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'login');
                      } else {
                        // TODO: mostrar error en pantalla
                        print(errorMessage);
                        NotificationsService.showSnackbar(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Espere' : 'Registrar',
                    style:
                        TextStyle(color: const Color.fromARGB(255, 37, 31, 31)),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  text: "¿Ya tienes cuenta?, da click en ",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Logear",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 53, 182, 143),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, 'login');
                          }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
