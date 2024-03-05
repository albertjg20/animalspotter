import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animalspotter/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
/*No volem el titol
  Widget _title() {
    return const Text('AnimalSpotter');
  }*/

  Widget _entryField(
      String title,
      TextEditingController controller,
      ) {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
        ),
      );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
        isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF9370DB)), // Cambia el color de fondo del botón a un púrpura más claro
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cambia el color del texto del botón
      ),
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF9370DB)), // Cambia el color de fondo del botón a un púrpura más claro
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cambia el color del texto del botón
      ),
      child: Text(isLogin ? 'Register instead' : 'Login intead'),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        /*appBar: AppBar( no volem appBAr, perque ens queda un espai lleig adalt
          title: _title(),
        ),*/
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/fondoPantalla.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.dstATop,
              ),
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _entryField('email', _controllerEmail),
                  _entryField('password', _controllerPassword),
                  _errorMessage(),
                  _submitButton(),
                  _loginOrRegisterButton(),
                ],
              ),
              Positioned(
                top: 0, // Ajusta la posición vertical de la imagen
                child: Image.asset(
                  'lib/assets/titolApp.png',
                  height: 100, // Ajusta el tamaño de la imagen
                  // También puedes agregar otras propiedades de estilo, como ancho, bordes, etc.
                ),
              ),
            ],
          ),
        )
      );
  }
}