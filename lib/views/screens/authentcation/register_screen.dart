import 'package:chat/controllers/auth_provider.dart';
import 'package:chat/models/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class RegisterScreen extends StatefulWidget {
  static String routeName = "RegisterScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var userController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isVisible = true;
  bool register = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        appBar: AppBar(title: Text("Create Account"),centerTitle: true,leading: IconButton(onPressed: (){
          Provider.of<AuthProvider>(context,listen: false).changeScreen();

        }, icon: Icon(Icons.arrow_back_ios)),),
        body: Center(
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                    children:[
                      TextFormField(
                        validator:(value){
                          if(value == null || value.isEmpty){
                            return "Please Enter Correct UserName";}
                          else
                            return null; },
                        controller: userController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "UserName",
                          //floatingLabelBehavior: FloatingLabelBehavior.always
                        ),
                      ),
                      SizedBox(height: 20,),
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
                            //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        obscureText: isVisible,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            labelText: "Password",
                            suffix: InkWell(
                              onTap:(){setState(() {
                                isVisible = !isVisible;
                            });},child:isVisible? Icon(Icons.visibility_off) :Icon(Icons.visibility_rounded)
                      ),
                        ),
                      ),
                      SizedBox(height: 40,),
                      Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child:register?Container(color:Colors.white,child: Center(child:CircularProgressIndicator.adaptive())):MaterialButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()) {
                                createAccount();
                            }
                            },
                            child: Text('REGISTER', style: TextStyle(color: Colors.white),),)),

                    ],
                  ),
              ),
          ),
        )
      ),
    );
  }
  void createAccount()async{
    setState(() {
      register = true;
    });
    String? error = await Provider.of<AuthProvider>(context,listen: false).createAccount(emailController.text, passController.text,userController.text);
    if(error != null){
      setState(() {
        register = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }
}
