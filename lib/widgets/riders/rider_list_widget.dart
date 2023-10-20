import 'package:bson/src/classes/object_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/users/user.dart';

class RiderListWidget extends StatelessWidget {
  RiderListWidget({
    super.key,
    required this.title,
    required this.riderList,
    this.isAdmin = false,
    required this.getUsers, // Ajout d'une fonction pour obtenir les utilisateurs
  });

  String title;
  List<User> riderList;
  bool isAdmin;
  final Function getUsers; // Fonction pour obtenir les utilisateurs

  void _deleteUser(ObjectId? id, context) {
    if (id != null) {
      User.deleteUser(id).then((isDeleted) {
        if (isDeleted) {
          getUsers();
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erreur de suppression'),
                content: const Text('La suppression de l\'utilisateur a échoué.'),
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: riderList.map((rider) {
                    return Card(
                      shape: const ContinuousRectangleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${rider.firstname} ${rider.lastname}"),
                                Text("${rider.age} ans"),
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
                                              _deleteUser(rider.id, context);
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
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
