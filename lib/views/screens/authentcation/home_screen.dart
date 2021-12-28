import 'package:chat/models/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        appBar: AppBar(title: Text("HomeScreen"),centerTitle: true,
        leading: IconButton(onPressed: (){FirebaseAuth.instance.signOut();}, icon: Icon(Icons.logout_outlined)),),
      ),
    );
  }
}
