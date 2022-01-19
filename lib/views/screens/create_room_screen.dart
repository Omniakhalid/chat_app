import 'package:chat/models/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CreateRoom extends StatefulWidget {
  static String routeName = "CreateRoom";
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  var formKey = GlobalKey<FormState>();
  var roomNameController = TextEditingController();
  var roomDescriptionController = TextEditingController();
  bool createdRoom = false;
  String? category;

  @override
  Widget build(BuildContext context) {
    return createdRoom?
        Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator.adaptive(),
                SizedBox(height: 15,),
                Text('Creating Room...')
              ],
            ),
          ),
        )
        :Container(
        decoration: Constants.decoration,
          child: Scaffold(
            appBar: AppBar(title: Text("Login"),centerTitle: true,),
            body: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.7,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 10,//shadow
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text('Create New Room',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15,horizontal: MediaQuery.of(context).size.width*0.2),
                          height: MediaQuery.of(context).size.height*0.1,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/group.png'),
                              fit: BoxFit.fill
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Form(
                          key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  validator:(value){
                                    if(value == null || value.isEmpty ||value.length<3){
                                      return "Room Name Must Be Consists of at Least 3 Characters";}
                                    else
                                      return null; },
                                  controller: roomNameController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Room Name',
                                  ),
                                ),
                                SizedBox(height: 30,),
                                DropdownButtonFormField<String>(
                                  validator:(value){
                                    if(value == null || value.isEmpty ||value == 'Select Room Category'){
                                      return "Please Select Room Category";}
                                    else
                                      return null; },
                                  onChanged: (value){setState(() {category = value;});},
                                  hint: Text('Select Room Category'),
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.all(10),
                                    //de 34an el border yb2a bara l2n el default gwa w byb2a feh line so8aur between items
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black)
                                    ),
                                    prefix: category == null ? null:
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      child: ImageIcon(Constants.getCategoryImage(category!,),size: 20,color: Colors.blue,),
                                    ),
                                  ),
                                  items: [
                                    DropdownMenuItem(child: Text('Movies'),value: 'Movies',),
                                    DropdownMenuItem(child: Text('Sports'),value: 'Sports',),
                                    DropdownMenuItem(child: Text('Music'),value: 'Music',),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                TextFormField(
                                  validator:(value){
                                    if(value == null || value.isEmpty ||value.length<3){
                                      return "Room Description Must Be Consists of at Least 3 Characters";}
                                    else
                                      return null; },
                                  maxLines: 3,
                                  minLines: 2,
                                  controller: roomDescriptionController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Room Description',
                                  ),
                                ),
                                SizedBox(height: 40,),
                                Container(
                                    width: double.infinity,
                                    color: Colors.blue,
                                    child: MaterialButton(
                                      onPressed: () {},
                                      child: Text('Create', style: TextStyle(color: Colors.white),),)),

                              ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
        )
    );
  }
}
