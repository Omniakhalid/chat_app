import 'package:chat/controllers/auth_provider.dart';
import 'package:chat/views/screens/authentcation/auth_screen.dart';
import 'package:chat/views/screens/authentcation/home_screen.dart';
import 'package:chat/views/screens/authentcation/login_screen.dart';
import 'package:chat/views/screens/authentcation/register_screen.dart';
import 'package:chat/views/screens/create_room_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(create:(context)=>AuthProvider(),child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        )
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          else if(snapshot.data != null)
            return HomeScreen();
          else
            return AuthScreen();
            //return LoginScreen();
        }
      ),
      routes: {
        LoginScreen.routeName: (buildContext) => LoginScreen(),
        CreateRoom.routeName: (buildContext) => CreateRoom(),

      },
      //initialRoute: CreateRoom.routeName,
    );
  }
}
