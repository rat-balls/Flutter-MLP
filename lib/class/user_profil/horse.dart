import 'package:mongo_dart/mongo_dart.dart';

class Horse {
  ObjectId? id;
  String name;
  int age;
  String coat;
  String breed;
  String gender;
  List<String> specialties;
  ObjectId? owner;
  List<ObjectId>? dp;

  Horse({
    this.id,
    required this.name,
    required this.age,
    required this.coat,
    required this.breed,
    required this.gender,
    required this.specialties,
    this.owner,
    this.dp,
  });

  bool isUserIsOwner(ObjectId? userId) {
    return userId == owner;
  }

  bool isUserInDp(ObjectId? userId) {
    return dp?.contains(userId) ?? false;
  }
}
