import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:provider/provider.dart';

class DbConnect{
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
      _dbref = await Db.create(connectionURI);
      await _dbref.open();
      print("Connected to MongoDB!");
      isConnected = true;
    } catch (e) {
      print("Error connecting to the database: $e");
    }
  }}



