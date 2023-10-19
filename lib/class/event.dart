import 'package:flutter_mlp/database/db_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Event {
  ObjectId? id;
  String type;
  List<ObjectId>? users;
  DateTime date;
  DateTime hour;
  ObjectId creator;
  String? place;
  List<ObjectId>? horses;
  String? discipline;
  int? duree;
  bool etat = false;

  Event(
      {this.id,
      required this.type,
      this.users,
      required this.date,
      required this.hour,
      required this.creator,
      required this.place,
      this.horses,
      required this.discipline,
      this.duree,
      this.etat = false});
}

//type de soirée
//personnes concernés

//user

//
