import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/database/db_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class User extends ChangeNotifier {
  User(
      {this.id,
      this.isAdmin = false,
      this.password,
      required this.firstname,
      required this.lastname,
      required this.age,
      required this.phonenumbers,
      required this.ffe,
      required this.email});

  ObjectId? id;
  bool isAdmin;
  String firstname;
  String lastname;
  String age;
  String phonenumbers;
  String ffe;
  String email;
  String? password;
  static bool isAuthenticated = false;

  static late User currentUser;

  static Future<User?> getUserInfo(String email) async {
    var db = DbConnect().dbref;
    var userCollection = db.collection('Users');

    User userinfo;

    try {
      var userData = await userCollection.findOne(where.eq("email", email));
      if (userData != null) {
        userinfo = User(
            id: userData['_id'],
            firstname: userData['firstname'],
            lastname: userData['lastname'],
            age: userData['age'],
            phonenumbers: userData['phonenumber'],
            ffe: userData['ffe'],
            email: userData['email'],
            isAdmin: userData['isAdmin']);
        return userinfo;
      } else {
        print("Aucun utilisateur trouvé avec l'e-mail: $email");
        return null;
      }
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
      return null;
    }
  }

  static Future<User?> getUserInfoFromId(String id) async {
    var db = DbConnect().dbref;
    var userCollection = db.collection('Users');

    User userinfo;
    ObjectId idToObjectId = ObjectId.fromHexString(id);

    try {
      var userData =
          await userCollection.findOne(where.eq("_id", idToObjectId));
      if (userData != null) {
        userinfo = User(
            id: userData['_id'],
            firstname: userData['firstname'],
            lastname: userData['lastname'],
            age: userData['age'],
            phonenumbers: userData['phonenumber'],
            ffe: userData['ffe'],
            email: userData['email']);

        return userinfo;
      } else {
        print("Aucun utilisateur trouvé avec l'id: $id");
        return null;
      }
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
      return null;
    }
  }

  static Future<void> updateUserInfo(User newInfos) async {
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
      print('Utilisateur mis à jour avec succès');
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }

  static Future<List<User>?> getAllUser() async {
    var db = DbConnect().dbref;
    var userCollection = db.collection('Users');
    List<User> userList = [];
    User userInfo;
    try {
      var usersData = await userCollection.find().toList();

      for (var user in usersData) {
        userInfo = User(
          id: user['_id'],
          firstname: user['firstname'],
          lastname: user['lastname'],
          age: user['age'],
          phonenumbers: user['phonenumber'],
          ffe: user['ffe'],
          email: user['email'],
        );

        userList.add(userInfo);
      }
      print(userList);
      return userList;
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
      return userList;
    }
  }

  static Future<void> associateUserWithHorse(
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

  static Future<void> addUserToHorseDp(
      ObjectId? horseId, ObjectId? userId) async {
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

  static Future<List<Horse>?> getOwnedHorses(ObjectId? userId) async {
    var db = DbConnect().dbref;
    var horsesCollection = db.collection('Horses');
    List<Horse> horsesList = [];

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

        horsesList.add(newOwnedHorse);
      }
      return horsesList;
    } catch (e) {
      print('Erreur lors de la récupération des chevaux possédés : $e');
      return null;
    }
  }

  static Future<List<Horse>?> getHorsesInDpList(ObjectId? userId) async {
    var db = DbConnect().dbref;
    var horsesCollection = db.collection('Horses');
    List<Horse> horsesList = [];

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

        horsesList.add(newHorse);
      }
      return horsesList;
    } catch (e) {
      print(
          'Erreur lors de la récupération des chevaux dans la liste de DP : $e');
    }
    return null;
  }

  static Future<bool> deleteUser(ObjectId userId) async {
    late bool isDeleted;
    var db = DbConnect().dbref;
    var userCollection = db.collection('Users');

    try {
      await userCollection.remove(where.eq('_id', userId));
      return isDeleted = true;
      print('Utilisateur supprimé avec succès');
    } catch (e) {
      return isDeleted = false;
      print('Erreur lors de la suppression de l\'utilisateur : $e');
    }
  }

  Future<void> userRegister(User user) async {
    var db = DbConnect().dbref;
    var collection = db.collection('Users');
    try {
      await collection.insertOne({
        'firstname': user.firstname,
        'lastname': user.lastname,
        'age': user.age,
        'ffe': user.ffe,
        'phonenumber': user.phonenumbers,
        'password': user.password,
        'email': user.email,
        'isAdmin': user.isAdmin,
      });
      print("User inscrit");
    } catch (e) {
      print('Erreur lors de l\'inscription: $e');
}}
static Future<Map<String, bool>> checkUniqueData(String email) async {
    try {
      var db = DbConnect().dbref;
  var collection = db.collection('Users');
      var emailExists = await collection.findOne({"email": email}) != null;


      print('$emailExists');
      return {"emailExists": emailExists};
    } catch (e) {
      print('Error checking user existence: $e');
      return {"usernameExists": false, "emailExists": false};
    }
  }

  static Future<bool> loginUser(String email, String password) async {
    var db = DbConnect().dbref;
    var collection = db.collection('Users');
    try {
      var result = await collection
          .findOne(where.eq("email", email).eq("password", password));
      if (result != null) {
        currentUser = User(
            id: result["_id"],
            firstname: result["firstname"],
            lastname: result["lastname"],
            age: result["age"],
            phonenumbers: result["phonenumber"],
            ffe: result["ffe"],
            email: result["email"],
            isAdmin: result["isAdmin"]);
        isAuthenticated = true;
      }
      currentUser.notifyListeners();
      return result != null;
    } catch (e) {
      print('La connexion a exhoue $e');
      return false;
    }
  }
}
