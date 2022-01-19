import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier{
  int currentIdx =0;
  void changeScreen(){
    if(currentIdx == 0)
      {currentIdx =1;}
    else
      {currentIdx =0;}
    notifyListeners();
  }
  Future<String?> createAccount(String email, String password, String userName) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      FirebaseAuth.instance.currentUser!.updateDisplayName(userName);
      currentIdx = 0;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }
  Future<String?> login(String email, String password)async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }catch(e){print(e);}
  }
  Future<String?> resetPassword(String email)async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }catch(error){
      return "Error has occurred";
    }
  }
}