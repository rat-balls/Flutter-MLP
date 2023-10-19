import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/rider.dart';

class CreateRiderPage extends StatefulWidget {
  const CreateRiderPage({super.key});

  @override
  _CreateRiderPageState createState() => _CreateRiderPageState();
}

class _CreateRiderPageState extends State<CreateRiderPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController horseNameController = TextEditingController();

  // Méthode pour créer un cavalier à partir des données du formulaire
  Rider createRider() {
    final String name = nameController.text;
    final int age = int.tryParse(ageController.text) ?? 0;
    final String horseName = horseNameController.text;

    // Créez une instance de Rider
    final Rider newRider = Rider(
      id: UniqueKey().toString(), // Vous pouvez générer un ID unique de différentes manières
      name: name,
      age: age,
      horseName: horseName,
    );

    return newRider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Création de Cavalier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nom du cavalier'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Âge du cavalier'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: horseNameController,
              decoration: InputDecoration(labelText: 'Nom du cheval'),
            ),
            ElevatedButton(
              onPressed: () {
                // Créez le cavalier et envoyez-le à la base de données ou à votre gestionnaire de données
                final newRider = createRider();
                print("Nouveau cavalier : ${newRider.toJson()}");

                // Vous pouvez maintenant envoyer les données du cavalier à votre base de données MongoDB
              },
              child: Text('Créer Cavalier'),
            ),
          ],
        ),
      ),
    );
  }
}
