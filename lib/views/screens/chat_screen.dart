import 'package:chat/models/constants.dart';
import 'package:chat/models/room.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  static String routeName = "ChatRoom";
  late Room room;
  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)!.settings.arguments as Room;
    return Container(
        decoration: Constants.decoration,
        child: Scaffold(
            appBar: AppBar(
              title: Text("${room.roomData.category} zone"),
              centerTitle: true,
              actions: [PopupMenuButton(icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [PopupMenuItem(child: Text('Leave'), value: 'leave')])],
            ),
            body: Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: Container(),
                    ),
                ),
            ),
        ),
    );
  }
}
