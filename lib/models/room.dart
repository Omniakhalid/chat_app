class RoomData{
  String name,category,description;
  List<dynamic> members;
  RoomData(this.name, this.category, this.description, this.members);
  RoomData.fromJson(Map<String,Object?>json):
      this(
      json['name']! as String,
      json['category']! as String,
      json['description']! as String,
      json['members']! as List<dynamic>,
  );
}
class Room{
  String id;
  RoomData roomData;
  Room(this.id, this.roomData);
  Room.fromJson(Map<String,Object?>json):this(
    json['id']! as String,
    RoomData.fromJson(json));
  Map<String,Object?> toJson(){
  return{
    'id': id,
    'name': roomData.name,
    'category': roomData.category,
    'description': roomData.description,
    'members': roomData.members
  };
  }
}