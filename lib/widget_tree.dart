import 'package:animalspotter/auth.dart';
import 'package:animalspotter/login.dart';
import 'package:animalspotter/homePage.dart';
import 'package:animalspotter/listAnimals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();

}

class _WidgetTreeState extends State<WidgetTree> {
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // Verifica el estado de autenticación al iniciar el widget
    Auth().authStateChanges.listen((user) {
      setState(() {
        _isUserLoggedIn = user != null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isUserLoggedIn ? ListAnimals() : LoginPage();
  }
}