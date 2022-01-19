import 'package:chat/controllers/room_provider.dart';
import 'package:chat/models/constants.dart';
import 'package:chat/models/room.dart';
import 'package:chat/views/screens/chat_screen.dart';
import 'package:chat/views/screens/join_room_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Grid extends StatelessWidget {
  final List<Room> rooms;
  Grid(this.rooms);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 8,
          childAspectRatio: 9 / 10,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (Provider.of<RoomProvider>(context, listen: false).isMember(rooms[index])) {
                Navigator.of(context).pushNamed(ChatRoom.routeName, arguments: rooms[index]);}
              else {Navigator.of(context).pushNamed(JoinRoom.routeName, arguments: rooms[index]);}},
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(decoration: BoxDecoration(image: DecorationImage(image: Constants.getCategoryImage(rooms[index].roomData.category),),),),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(rooms[index].roomData.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),),
                          SizedBox(height: 5,),
                          Text('${rooms[index].roomData.members.length} member${rooms[index].roomData.members.length > 1 ? 's' : ''}',),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: rooms.length
    );
  }
}

