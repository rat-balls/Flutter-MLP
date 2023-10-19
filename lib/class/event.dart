import 'package:flutter_mlp/database/db_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Event {
  ObjectId? id;
  String type;
  List<ObjectId>? users;
  DateTime date;
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
      required this.creator,
      required this.place,
      this.horses,
      required this.discipline,
      this.duree,
      this.etat = false});

  get hour => null;

  void insertParty(Event event) async {
    var db = DbConnect().dbref;

    var eventCollection = db.collection("Events");

    try {
      eventCollection.insertOne({
        'type': event.type,
        'discipline': event.discipline,
        'date': event.date,
        'users': event.users,
        'creator': event.creator,
        'etat': event.etat,
      });
      print('$event inséré');
    } catch (e) {
      print('erreur : $e');
    }
  }
}
