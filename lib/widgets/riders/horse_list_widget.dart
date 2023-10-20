import 'package:flutter/material.dart';
import 'package:bson/src/classes/object_id.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/widgets/controllerPage.dart';
import 'package:flutter_mlp/widgets/profil/edit_horse_form.dart';

class HorsesListWidget extends StatelessWidget {
  HorsesListWidget({
    super.key,
    required this.title,
    required this.horsesList,
    this.isAdmin = false,
    required this.getHorses,
  });

  String title;
  List<Horse> horsesList;
  bool isAdmin;
  final Function getHorses;

  void _deleteHorse(ObjectId? id, context) {
    if (id != null) {
      Horse.deleteHorse(id).then((isDeleted) {
        if (isDeleted) {
          getHorses();
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erreur de suppression'),
                content: const Text('La suppression du cheval a échoué.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Fermer'),
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: horsesList.map((horse) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: const ContinuousRectangleBorder(),
                        child: Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${horse.name}"),
                                Text("${horse.age} ans"),
                                Text(
                                    "Spécialités: ${horse.specialties.join(', ')}")
                              ],
                            ),
                            if (isAdmin)
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirmation de suppression'),
                                        content: const Text('Êtes-vous sûr de vouloir supprimer cet utilisateur ?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Annuler'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _deleteHorse(horse.id, context);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Supprimer'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text('Supprimer'),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
