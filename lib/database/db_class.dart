import 'package:mongo_dart/mongo_dart.dart';

class DbConnect {
  static const connectionURI =
      'mongodb+srv://root:root@cluster0.g9po3tv.mongodb.net/flutter_mlp?retryWrites=true&w=majority';

  // ignore: prefer_typing_uninitialized_variables
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
      print("Connected to MongoDB!");
      isConnected = true;
    } catch (e) {
      print("Error connecting to the database: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getRiders() async {
    if (isConnected) {
      final collection = _dbref.collection('riders');
      final cursor = collection.find(); // Vous pouvez ajouter des critères de recherche si nécessaire
      final riders = await cursor.toList();
      return riders;
    } else {
      return [];
    }
  }
}
