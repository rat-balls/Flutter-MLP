import 'package:flutter_mlp/database/db_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../database/db_class.dart';

class Event {
  ObjectId? id;
  String type;
  List<dynamic>? users;
  DateTime date;
  DateTime? time;
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
      this.time,
      required this.creator,
      required this.place,
      this.horses,
      required this.discipline,
      this.duree,
      this.etat = false});

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
            place: event?['place'],
            horses: List<ObjectId>.from(event['horses']),
            discipline: event['discipline'],
            duree: event['duree'],
            etat: event['etat']);
        eventList.add(eventInfo);
      }
      print(eventList);
      return eventList;
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
      return eventList;
    }
  }
//-----------------------------------------------------------------------
//PROGRAMMER COMPETITION

  void insertCompetition(Event event) async {
    var db = DbConnect().dbref;

    var eventCollection = db.collection("Events");

    try {
      eventCollection.insertOne({
        'type': event.type,
        'date': event.date,
        'discipline': event.discipline,
        'users': event.users,
        'creator': event.creator,
        'etat': event.etat,
        'place': event.place,
      });
      print('$event inséré');
    } catch (e) {
      print('erreur : $e');
    }
  }

//-----------------------------------------------------------------------
//PROGRAMMER SOIREE

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

//-----------------------------------------------------------------------
//PROGRAMMER COURS

  void insertLesson(Event event) async {
    var db = DbConnect().dbref;

    var eventCollection = db.collection("Events");

    try {
      eventCollection.insertOne({
        'type': event.type,
        'place': event.place,
        'discipline': event.discipline,
        'date': event.date,
        'creator': event.creator,
        'etat': event.etat,
      });
    } catch (e) {
      print('erreur : $e');
    }
  }
//------------------------------------------------------------------------

  static Future<Map<DateTime, List<Event>>?> getAllEventsTimed() async {
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
          date: DateTime.parse(DateFormat('yyyy-MM-dd').format(event['date'])),
          time: DateTime.parse(
              DateFormat('yyyy-MM-dd kk:mm:ss').format(event['date'])),
          discipline: event['discipline'],
          duree: event?['duree'],
          etat: event?['etat'],
          place: event['place'],
        );
        print(eventInfo.date);
        if (eventMap[eventInfo.date] == null) {
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

  static Future<List<Event>?> getValideEvents() async {
    var db = DbConnect().dbref;
    var eventCollection = db.collection('Events');
    List<Event> eventList = [];
    Event eventInfo;
    try {
      var eventsData = await eventCollection.find().toList();

      for (var event in eventsData) {
        if (event['etat'] == true) {
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
              etat: event['etat']);
          eventList.add(eventInfo);
        }
      }
      print(eventList);
      return eventList;
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
      return eventList;
    }
  }

  static Future<void> acceptEvent(ObjectId? eventId) async {
    var db = DbConnect().dbref;
    var eventCollection = db.collection('Events');
    try {
      await eventCollection.update(
          where.eq('_id', eventId), modify.set('etat', true));
      print('Evenement accepter');
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }

  static Future<void> deleteEvent(ObjectId? eventId) async {
    var db = DbConnect().dbref;
    var eventCollection = db.collection('Events');
    try {
      await eventCollection.deleteOne(where.eq('_id', eventId));
      print('Evenement supprimer');
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }
}
