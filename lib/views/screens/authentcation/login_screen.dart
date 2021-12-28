import 'package:chat/controllers/auth_provider.dart';
import 'package:chat/models/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
static String routeName = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
var emailController = TextEditingController();

var passController = TextEditingController();

var formKey = GlobalKey<FormState>();

bool loggedIn = false,isReset = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        appBar: AppBar(title: Text("Login"),centerTitle: true,),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(alignment:Alignment.centerLeft,child: Text("Welcome Back!",style: Constants.txtStyle,)),
                SizedBox(height: 15,),
                Form(
                      key: formKey,
                  child: Column(
                      children:[
                        TextFormField(
                          validator:(value){
                            if(value == null || value.isEmpty || !EmailValidator.validate(value)){
                              return "Please Enter Correct Email";}
                            else
                            return null; },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                          labelText: "Email",
                      ),
                    ),
                        SizedBox(height: 20,),
                        TextFormField(
                          validator:(value){
                            if(value == null || value.isEmpty || value.length<6){
                              return "Please Enter Strong Password";}
                            else
                              return null;},
                          controller: passController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              labelText: "Password",
                          ),
                        ),
                      ],
                  )
                ),
                Align(alignment:Alignment.centerRight,child: TextButton(onPressed: (){resetPassword();}, child: isReset?CircularProgressIndicator.adaptive():Text("Forget Password!",style: TextStyle(fontSize:12, color: Colors.black),))),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: loggedIn?Container(color:Colors.white,child: Center(child:CircularProgressIndicator.adaptive())):MaterialButton(
                      onPressed: () {
                        if(formKey.currentState!.validate())
                          login();
                        },
                    child: Text('LOGIN', style: TextStyle(color: Colors.white),),)),
                SizedBox(height: 10,),
                Align(alignment:Alignment.centerLeft,
                    child: TextButton(
                        onPressed: (){
                          Provider.of<AuthProvider>(context,listen: false).changeScreen();
                          //Navigator.of(context).pushNamed(RegisterScreen.routeName);
                          },
                        child: Text("Or Create a New Account?",style: TextStyle(color: Colors.blue),)))
              ],
            ),
          ),
        ),
      ),
    );
  }

void login()async{
  setState(() {
    loggedIn = true;
  });
  String? error = await Provider.of<AuthProvider>(context,listen: false).login(emailController.text, passController.text);
  if(error != null){
    setState(() {
      loggedIn = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }
}
void resetPassword()async{
  setState(() {isReset = true;});
  String? error = await Provider.of<AuthProvider>(context,listen: false).resetPassword(emailController.text);
  setState(() {isReset = false;});
  if(error != null){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }
  else
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Reset Password Email has been Sent")));

}
}
