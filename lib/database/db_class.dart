import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:provider/provider.dart';

class DbConnect extends ChangeNotifier {
  static const connectionURI =
      'mongodb+srv://root:root@cluster0.g9po3tv.mongodb.net/flutter_mlp?retryWrites=true&w=majority';

  static late Db _dbref;

  bool isConnected = false;

  Db get dbref => _dbref;

  set dbref(Db value) {
    _dbref = value;
  }

  Future<void> connectToDb() async {
    try {
      _dbref = Db(connectionURI);
      await _dbref.open();
      print("Connected to MongoDB!");
      isConnected = true;
    } catch (e) {
      print("Error connecting to the database: $e");
    }
  }

  Future<List<Map<String, dynamic>>?> getRiders() async {
    if (isConnected) {
      final collection = _dbref.collection('user');
      final cursor = collection.find();
      final riders = await cursor.toList();
      return riders;
    } else {
      return null; // Retournez null au lieu d'une liste vide en cas de non connexion.
    }
  }

  // Méthode pour vérifier si l'utilisateur existe et retourner son email
  static Future<bool> loginUser(BuildContext context, String name, String password) async {
    try {
      var db = DbConnect(); // Créez une instance de DbConnect
      await db.connectToDb(); // Connectez-vous à la base de données
      var collection = db.dbref.collection('users');
      var user = await collection.findOne({
        'name': name,
        'password': password // Attention: stocker des mots de passe en texte brut est une mauvaise pratique!
      });
      db.dbref.close(); // Fermez la connexion à la base de données

      bool isUserValid = user != null;
      if (isUserValid) {
        String? email = await DbConnect.getEmailFromName(name);
        if (email != null) {
          // Provider.of<User>(context, listen: false).login(name, email, "phone", "profilePic", 0, "ffelink", "role", "level");
          return true;
        } else {
          print("Erreur lors de la récupération de l'email");
          return false;
        }
      }
      return false;
    } catch (e) {
      print("Error in loginUser: $e");
      return false;
    }
  }

static Future<String?> getEmailFromName(String name) async {
  try {
    var db = DbConnect();
    await db.connectToDb();
    var collection = db.dbref.collection('users');
    var user = await collection.findOne({'name': name});
    db.dbref.close();

    if (user != null) {
      return user['email']; // Supposons que l'e-mail est stocké sous la clé 'email' dans la base de données
    } else {
      return null; // Si l'utilisateur n'est pas trouvé, retournez null
    }
  } catch (e) {
    print("Error in getEmailFromName: $e");
    return null;
  }
}

  // Méthode pour enregistrer un utilisateur
  Future<bool> registerUser(String name, String firstname, String age, String ffe, String mail, String number, String role, String password) async {
    try {
      if (isConnected) {
        var collection = _dbref.collection('Users');
        var result = await collection.insert({
          'name': name,
          'firstname': firstname,
          'age': age,
          'ffe': ffe,
          'mail': mail,
          'number': number,
          'role': role,
          'password': password,
        });
        return result != null;
      } else {
        print("Not connected to the database.");
        return false;
      }
    } catch (e) {
      print("Error in registerUser: $e");
      return false;
    }
  }
}

