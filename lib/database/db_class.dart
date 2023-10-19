import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DbConnect {
  static const connectionURI =
      'mongodb+srv://root:root@cluster0.g9po3tv.mongodb.net/flutter_mlp?retryWrites=true&w=majority';

  late final _dbref;

  bool isConnected = false;

  get dbref => _dbref;

  set dbref(value) {
    _dbref = value;
  }

  Future<void> connectToDb() async {
    try {
      _dbref = await Db.create(connectionURI);
      await _dbref.open();
      print("connected !");
      isConnected = true;
    } catch (e) {
      print("Erreur lors de la connexion à la db $e");
    }
  }

  
Future<bool> LoginUser(String password, String mail, TextEditingController usernameController, TextEditingController passwordController) async {
  var collection = _dbref.collection('Users');

  var result = await collection.findOne({
    'mail': mail,
    'password': password,
  });

  String username = usernameController.text;
  String enteredPassword = passwordController.text;

  return result != null && username == mail && enteredPassword == password;
}


    Future<bool> RegisterUser(String name, String firstname, String age, String ffe, String mail, String number, String role, String password) async {
    
    var collection = _dbref.collection('Users');

    var result = await collection.insert({
      'name' : name,
      'firstname' : firstname,
      'age' : age,
      'ffe' : ffe,
      'mail' : mail,
      'number' : number,
      'role' : role,
      'password' :password,
    });
    return result != null;
  }

}
