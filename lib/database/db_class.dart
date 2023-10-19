import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DbConnect extends ChangeNotifier {
  static const connectionURI =
      'mongodb+srv://root:root@cluster0.g9po3tv.mongodb.net/flutter_mlp?retryWrites=true&w=majority';

  static late Db _dbref;

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
}
