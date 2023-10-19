import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_mlp/class/rider.dart';

class DbConnect {
  final String dbName = 'votre_nom_de_base_de_donnees';
  final String collectionName = 'votre_collection_de_cavaliers';
  late Db db;

  DbConnect() {
    db = Db('mongodb://your_mongodb_connection_string');
  }

  Future<List<Rider>> getRiders() async {
    final collection = db.collection(collectionName);

    await db.open();

    final ridersData = await collection.find().toList();

    final riders = ridersData.map((data) => Rider.fromJson(data)).toList();

    await db.close();

    return riders;
  }
}
