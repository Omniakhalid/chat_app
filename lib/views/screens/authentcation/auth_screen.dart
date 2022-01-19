import 'package:chat/controllers/auth_provider.dart';
import 'package:chat/views/screens/authentcation/login_screen.dart';
import 'package:chat/views/screens/authentcation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static String routeName = "AuthScreen";
  final screens = [RegisterScreen(),LoginScreen()];
    @override
    Widget build(BuildContext context) {
      return screens[Provider.of<AuthProvider>(context).currentIdx];
    }
}
