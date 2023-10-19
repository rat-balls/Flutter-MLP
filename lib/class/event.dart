import 'package:flutter_mlp/database/db_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../database/db_class.dart';

class Event {
  ObjectId? id;
  String type;
  List<dynamic>? users;
  DateTime date;
  ObjectId creator;
  String? place;
  List<dynamic>? horses;
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
      this.etat}
      );

  static Future<List<Event>?> getAllEvents() async {
    var db = DbConnect().dbref;
    var eventCollection = db.collection('Events');
    List<Event> eventList = [];
    Event eventInfo;
    try {
      var eventsData = await eventCollection.find().toList();

      for (var event in eventsData) {
        eventInfo = Event(
            id: event['id'],
            type: event['type'],
            users: event?['event'],
            date: event['date'],
            creator: event['creator'],
            place: event['place'],
            horses: event?['horses'],
            discipline: event['discipline'],
            duree: event?['duree'],
            etat: event?['bool']
        );
        print(eventInfo);
        eventList.add(eventInfo);
      }
      print(eventList);
      return eventList;
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
      return eventList;
    }
}

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

  static Future<Map<DateTime, List<Event>>?> getAllCours() async {
    var db = DbConnect().dbref;
    var eventCollection = db.collection('Events');
    List<Event> eventList = [];
    Map<DateTime, List<Event>> eventMap = {};
    Event eventInfo;
    try {
      var eventsData = await eventCollection.find().toList();

      for (var event in eventsData) {
        eventInfo = Event(
            id: event['id'],
            type: event['type'],
            users: event?['users'],
            creator: event['creator'],
            date: event['date'],
            discipline: event['discipline'],
            duree: event?['duree'],
            etat: event?['etat'],
            place: event['place'],
        );
        if(eventMap[eventInfo.date] == null) {
          eventMap[eventInfo.date] = [];
        }
        eventMap[eventInfo.date]?.add(eventInfo);
      }
      print(eventList);
      return eventMap;
    } catch (e, stack) {
      print("Erreur lors de la récupération des données : $e");
      print(stack);
      return eventMap;
    }
  }
}
