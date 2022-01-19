import 'package:chat/controllers/room_provider.dart';
import 'package:chat/models/constants.dart';
import 'package:chat/models/room.dart';
import 'package:chat/views/screens/create_room_screen.dart';
import 'package:chat/views/widgets/grid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        appBar: AppBar(title: Text("HomeScreen"),centerTitle: true,
          leading: IconButton(onPressed: (){FirebaseAuth.instance.signOut();}, icon: Icon(Icons.logout_outlined)),),
        body: StreamBuilder<QuerySnapshot<Room>>(
          stream: Provider.of<RoomProvider>(context, listen: false).roomRef.snapshots(),
          builder: (context, snapshot) {
            if(ConnectionState.waiting == snapshot.connectionState){
              return Center(child: CircularProgressIndicator.adaptive(),);
            }
            else if (snapshot.hasError){
              return Center(child: Text('Error has occurred please try again later!'),);
            }
            final allRooms = snapshot.data!.docs.map((e) => e.data()).toList();
            final myRooms = allRooms.where((room) => Provider.of<RoomProvider>(context).isMember(room)).toList();//treatable  .tolist()
            final browse = allRooms.where((room) => !Provider.of<RoomProvider>(context).isMember(room)).toList();
             return Column(
              children: [
                TabBar(
                  indicatorColor: Colors.white,
                  controller: tabController,
                  tabs: [Tab(text:'My Rooms'),Tab(text: 'Browse',)],),
                Expanded(child:
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Grid(myRooms),
                        Grid(browse),
                ],),
                  ))
              ],
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){Navigator.of(context).pushNamed(CreateRoom.routeName);},
        ),
      ),
    );
  }
}
