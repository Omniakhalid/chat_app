import 'package:chat/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class RoomProvider with ChangeNotifier{
  final roomRef = FirebaseFirestore.instance.collection('Rooms').withConverter<Room>(
      fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson());

  Future<String?> createRoom(RoomData roomData)async{
    try{
      final roomDoc = roomRef.doc();
      Room room = Room(roomDoc.id,roomData);
      await roomRef.doc(room.id).set(room);
      return null;
    }catch(error){
      print(error);
      return 'Error has occurred, please try again later!';
    }
  }
}