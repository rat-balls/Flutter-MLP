import 'package:mongo_dart/mongo_dart.dart';

import '../database/db_class.dart';

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
  bool? etat;

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
      this.etat});

    static Future<List<Event>?> getAllEvents() async {
      var db = DbConnect().dbref;
      var eventCollection = db.collection('Events');
      List<Event> eventList = [];
      Event eventInfo;
      try {
        var eventsData = await eventCollection.find().toList();

        for (var event in eventsData) {
          eventInfo = Event(
              id: event['_id'],
              type: event['type'],
              users: List<ObjectId>.from(event['users']),
              date: event['date'],
              creator: event['creator'],
              place: event['place'],
              horses: List<ObjectId>.from(event['horses']),
              discipline: event['discipline'],
              duree: event['duree'],
              etat: event['bool']
          );

          seventList.add(eventInfo);
        }
        print(eventList);
        return eventList;
      } catch (e) {
        print("Erreur lors de la récupération des données : $e");
        return eventList;
      }
    }
}