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
      print("connected !");
      isConnected = true;
    } catch (e) {
      print("Erreur lors de la connexion à la db $e");
    }
  }
}
