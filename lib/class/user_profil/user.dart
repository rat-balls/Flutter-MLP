import 'package:mongo_dart/mongo_dart.dart';

class User {
  User(
      {this.id,
      required this.firstname,
      required this.lastname,
      required this.age,
      required this.phonenumbers,
      required this.ffe,
      required this.email});

  ObjectId? id;
  String firstname;
  String lastname;
  String age;
  String phonenumbers;
  String ffe;
  String email;
}
