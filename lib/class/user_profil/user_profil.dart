import 'package:flutter_mlp/class/user_profil/horse.dart';
import 'package:flutter_mlp/class/user_profil/user.dart';
import 'package:flutter_mlp/database/db_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserProfil {
  late User _currentUser;

  late List<Horse> _horsesList = [];

  late List<Horse> _ownedHorsesList = [];

  late List<Horse> _userHorsesDp = [];

  get currentUser => _currentUser;

  get horsesList => _horsesList;

  get ownedHorsesList => _ownedHorsesList;

  get userHorsesDp => _userHorsesDp;

  Future<void> getUserInfo(String email) async {
    var db = DbConnect().dbref;
    var userCollection = db.collection('Users');

    try {
      var userData = await userCollection.findOne(where.eq("email", email));
      if (userData != null) {
        _currentUser = User(
            id: userData['_id'],
            firstname: userData['firstname'],
            lastname: userData['lastname'],
            age: userData['age'],
            phonenumbers: userData['phonenumber'],
            ffe: userData['ffe'],
            email: userData['email']);
      } else {
        print("Aucun utilisateur trouvé avec l'e-mail: $email");
      }
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
    }
  }

  Future<void> updateContactInfo(User newInfos) async {
    var db = DbConnect().dbref;
    var collection = db.collection('Users');
    try {
      await collection.update(
          where.eq('email', newInfos.email),
          modify
              .set('email', newInfos.email)
              .set('firstname', newInfos.firstname)
              .set('lastname', newInfos.lastname)
              .set('ffe', newInfos.ffe)
              .set('phonenumber', newInfos.phonenumbers)
              .set('age', newInfos.age));
      print('Contact mis à jour avec succès');
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }

  Future<void> getHorses() async {
    var db = DbConnect().dbref;
    var horsesCollection = db.collection('Horses');

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

        _horsesList.add(newHorse);
      }
    } catch (e) {
      print('Erreur lors de la récupération des chevaux : $e');
    }
  }

  Future<void> associateUserWithHorse(
      ObjectId? horseId, ObjectId? userId) async {
    var db = DbConnect().dbref;

    try {
      var horsesCollection = db.collection('Horses');
      await horsesCollection.update(
        where.eq('_id', horseId),
        modify.set('owner', userId),
      );

      print("Cheval associé à l'utilisateur avec succès");
    } catch (e) {
      print("Erreur lors de l'association du cheval à l'utilisateur : $e");
    }
  }

  Future<void> addUserToHorseDp(ObjectId? horseId, ObjectId? userId) async {
    var db = DbConnect().dbref;

    try {
      var horsesCollection = db.collection('Horses');
      var horse = await horsesCollection.findOne(where.eq('_id', horseId));

      if (horse != null) {
        if (!horse['dp'].contains(userId)) {
          horse['dp'].add(userId);
          await horsesCollection.update(
            where.eq('_id', horseId),
            modify.set('dp', horse['dp']),
          );
          print("Utilisateur ajouté à la liste de dp du cheval avec succès");
        } else {
          print("L'utilisateur est déjà dans la liste de dp du cheval");
        }
      }
    } catch (e) {
      print(
          "Erreur lors de l'ajout de l'utilisateur à la liste de dp du cheval : $e");
    }
  }

  Future<void> updateHorseInfo(Horse horse) async {
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

  Future<void> getOwnedHorses(ObjectId? userId) async {
    var db = DbConnect().dbref;
    var horsesCollection = db.collection('Horses');

    try {
      var ownedHorsesData =
          await horsesCollection.find(where.eq('owner', userId)).toList();

      for (var horse in ownedHorsesData) {
        var newOwnedHorse = Horse(
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

        _ownedHorsesList.add(newOwnedHorse);
      }
    } catch (e) {
      print('Erreur lors de la récupération des chevaux possédés : $e');
    }
  }

  Future<void> getHorsesInDpList(ObjectId? userId) async {
    var db = DbConnect().dbref;
    var horsesCollection = db.collection('Horses');

    try {
      var dpHorsesData = await await horsesCollection
          .find(where.eq('dp', userId).ne('owner', userId))
          .toList();

      for (var horse in dpHorsesData) {
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

        _userHorsesDp.add(newHorse);
      }
    } catch (e) {
      print(
          'Erreur lors de la récupération des chevaux dans la liste de DP : $e');
    }
  }
}
