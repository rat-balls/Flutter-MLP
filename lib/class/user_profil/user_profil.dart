import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/database/db_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserProfil {
  //late User _currentUser;

  late List<Horse> _horsesList = [];

  late List<Horse> _ownedHorsesList = [];

  late List<Horse> _userHorsesDp = [];

  //get currentUser => _currentUser;

  get horsesList => _horsesList;

  get ownedHorsesList => _ownedHorsesList;

  get userHorsesDp => _userHorsesDp;
}
