import 'package:chat/controllers/room_provider.dart';
import 'package:chat/models/constants.dart';
import 'package:chat/models/room.dart';
import 'package:chat/views/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinRoom extends StatefulWidget {
  static String routeName = "JoinRoom";
  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  bool joined = false;
  late Room room;
  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)!.settings.arguments as Room;
    return joined?
    Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator.adaptive(),
            SizedBox(height: 15,),
            Text('Joining Room...')
          ],
        ),
      ),
    )
        :Container(
          decoration: Constants.decoration,
          child: Scaffold(
            appBar: AppBar(
              title: Text("${room.roomData.category} zone"),
              centerTitle: true,
            ),
            body: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text('Hello, Welcome to Our chat Room'),
                        SizedBox(height: 5,),
                        Text('Join The ${room.roomData.category} Zone',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        SizedBox(height: 5,),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15,horizontal: MediaQuery.of(context).size.width*0.2),
                          height: MediaQuery.of(context).size.height*0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Constants.getCategoryImage(room.roomData.category),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(room.roomData.description),
                        SizedBox(height: 15,),
                        Container(
                            width: MediaQuery.of(context).size.width*.7,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {
                                joinRoom();
                              },
                              child: Text('Join', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),)),
                      ],
                    ),
                  ),
                ),

            ),
          ),
      ),
    );
  }

  void joinRoom()async{
    setState(() {
      joined = true;
    });
    String? error = await Provider.of<RoomProvider>(context,listen: false).joinRoom(room);
    if(error == null){
      Navigator.of(context).pushReplacementNamed(ChatRoom.routeName);
    }
    else {
      setState(() {joined = false;});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }
}
