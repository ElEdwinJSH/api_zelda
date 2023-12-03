import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:api_zelda/providers/login_form_provider.dart';
//import 'package:api_zelda/screens/screens.dart';
import 'package:api_zelda/services/auth_services.dart';
import 'package:api_zelda/services/notifications_services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

 static bool isMusicPlayed = false; 
 late String routeName;

  @override
  void initState() {
    super.initState();
if(!isMusicPlayed){
  
    playm('File_Select.mp3');
    isMusicPlayed = true;
}


 
  }

  @override
  void dispose() {
 
      routeName = ModalRoute.of(context)?.settings.name ?? '';
   if (routeName == 'register') {
    // No hagas nada si la ruta es "register"
  }

    fadeOutAndStopMusic();
  
 
  
  // Llamas a la función que detiene la música al cerrar la pantalla
    super.dispose();
  }

   void fadeOutAndStopMusic() async {
    const fadeDuration = Duration(milliseconds: 500); // Puedes ajustar la duración del fade out según tus preferencias
    const fadeSteps = 10;
    const initialVolume = 1.0;

    for (int i = 0; i < fadeSteps; i++) {
      double volume = initialVolume - (i / fadeSteps);
      await player.setVolume(volume);
      await Future.delayed(fadeDuration ~/ fadeSteps);
    }

    player.stop(); // Detiene la reproducción después del fade out
  }

 
 AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Column( mainAxisAlignment: MainAxisAlignment.center,children: [Container(child: Column(children: [const SizedBox(height: 5,),
      Text('Login'),const SizedBox(height: 5,), ChangeNotifierProvider(   create: (_) => LoginFormProvider(), child: _Login())],))])),
    );
  }

    Future<void> playm(String path) async {
    await player.play(AssetSource(path));
  }
}

 

class _Login extends StatefulWidget {
  
  const _Login({super.key});

  @override
  State<_Login> createState() => _LoginState();
}

class _LoginState extends State<_Login> {
 
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
   return Container(
      child: Form(
          key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [//qui decia <widget>
            
              Padding(padding:  EdgeInsets.all(16.0),child:   TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'user@example.com',
                  labelText: 'Correo electrónico',
                  ),
               onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),),
             Padding(
              padding: EdgeInsets.all(16.0),
              child:  TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: '*****',
                  labelText: 'Contraseña',
                ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            ), ElevatedButton(
            onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        // TODO: validar si el login es correcto
                        final String? errorMessage = await authService.login(
                            loginForm.email, loginForm.password);

                        if (errorMessage == null) {
                      
                          Navigator.pushReplacementNamed(context, 'home');
                             
                        } else {
                          // TODO: mostrar error en pantalla
                          // print( errorMessage );
                          NotificationsService.showSnackbar(errorMessage);
                          loginForm.isLoading = false;
                        }
                      },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Espere' : 'Ingresar',
                      style: TextStyle(color: const Color.fromARGB(255, 37, 31, 31)),
                    )),
          ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  text: "¿No tienes una cuenta?, da click en ",
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "registrar",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                           Navigator.pushReplacementNamed(context, 'register');
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