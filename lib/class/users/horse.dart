import 'package:flutter_mlp/database/db_class.dart';
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

  static Future<List<Horse>?> getHorses() async {
    var db = DbConnect().dbref;
    var horsesCollection = db.collection('Horses');

    List<Horse> horseList = [];

    try {
      var horsesData = await horsesCollection.find().toList();
      for (var horse in horsesData) {
        var newHorse = Horse(
          id: horse['_id'],
          name: horse['name'],
          age: horse['age'],
          coat: horse['coat'],
          breed: horse['breed'],
          gender: horse['gender'],
          specialties: List<String>.from(horse['specialties']),
          owner: horse['owner'],
          dp: List<ObjectId>.from(horse['dp']),
        );

        horseList.add(newHorse);
      }
      return horseList;
    } catch (e) {
      print('Erreur lors de la récupération des chevaux : $e');
    }
    return null;
  }

  static Future<List<Horse>?> getNonOwnedHorses(ObjectId? userId) async {
    var db = DbConnect().dbref;
    var horsesCollection = db.collection('Horses');

    List<Horse> horseList = [];

    try {
      var horsesData = await horsesCollection
          .find(where.ne("owner", userId).ne("dp", userId))
          .toList();

      for (var horse in horsesData) {
        var newHorse = Horse(
          id: horse['_id'],
          name: horse['name'],
          age: horse['age'],
          coat: horse['coat'],
          breed: horse['breed'],
          gender: horse['gender'],
          specialties: List<String>.from(horse['specialties']),
          owner: horse['owner'],
          dp: List<ObjectId>.from(horse['dp']),
        );

        horseList.add(newHorse);
      }
      return horseList;
    } catch (e) {
      print('Erreur lors de la récupération des chevaux : $e');
    }
    return null;
  }

  static Future<void> updateHorseInfo(Horse horse) async {
    var db = DbConnect().dbref;
    var horsesCollection = db.collection('Horses');

    try {
      await horsesCollection.update(
        where.eq('_id', horse.id),
        modify
            .set('name', horse.name)
            .set('age', horse.age)
            .set('coat', horse.coat)
            .set('breed', horse.breed)
            .set('gender', horse.gender)
            .set('specialties', horse.specialties),
      );

      print('Informations du cheval mises à jour avec succès');
    } catch (e) {
      print('Erreur lors de la mise à jour des informations du cheval : $e');
    }
  }

  static Future<void> addHorse(Horse horse) async {
    var db = DbConnect().dbref;
    var horsesCollection = db.collection('Horses');

    try {
      await horsesCollection.insertOne({
        "name": horse.name,
        "age": horse.age,
        "coat": horse.coat,
        "breed": horse.breed,
        "gender": horse.gender,
        "specialties": horse.specialties,
        "owner": horse.owner,
        "dp": horse.dp,
      });
      print("Cheval ajouté avec succès");
    } catch (e) {
      print("Erreur lors de l'ajout du cheval : $e");
    }
  }

  static Future<bool> deleteHorse(ObjectId horseId) async {
    late bool isDeleted;
    var db = DbConnect().dbref;
    var horseCollection = db.collection('Horses');

    try {
      await horseCollection.remove(where.eq('_id', horseId));
      return isDeleted = true;
      print('Cheval supprimé avec succès');
    } catch (e) {
      return isDeleted = false;
      print('Erreur lors de la suppression du Cheval : $e');
    }
  }
}
