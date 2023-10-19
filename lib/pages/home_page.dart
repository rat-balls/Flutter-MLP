import 'package:flutter/material.dart';
import 'package:flutter_mlp/database/db_class.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.db});

  final DbConnect db;

  Future<List<Object>> listeEvents(DbConnect db) async {
    var collection = db.dbref('Events');
    List<Object> events = [];
    try {
      var result = await collection.find().toList();
      for (var doc in result) {
        events.add(doc);
      }
    } catch (e) {
      print('Erreur lors de la récupération : $e');
    }
    await Future.delayed(Duration(seconds: 3));
    return events;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<ListView>(
                future: Future<ListView>.delayed(Duration(seconds: 2)),
                itemCount: events.whenComplete(() => null),
              // Pour l'instant, nous affichons 10 contacts en dur
              builder: (BuildContext context, AsyncSnapshot<ListView> snapshot) {
                return Card(
                  //color: events[index].color,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(Icons.contact_phone),
                          Column(
                            children: <Widget>[
                              Text('   ${contacts[index]
                                  .prenom} ${contacts[index].nom}'),
                              Text('   ${contacts[index].tel}'),
                            ],
                          ),
                        ],
                      ),
                      Text('${contacts[index].mail}'),
                    ],
                  ),
                );
              },
            ),
            ),
          ],
        ),
      );
      throw UnimplementedError();
  }
}
