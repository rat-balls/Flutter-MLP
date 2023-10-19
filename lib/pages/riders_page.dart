import 'package:flutter/material.dart';
import 'package:flutter_mlp/database/db_class.dart';
import 'package:flutter_mlp/class/rider.dart';

class RidersPage extends StatefulWidget {
  @override
  _RidersPageState createState() => _RidersPageState();
}

class _RidersPageState extends State<RidersPage> {
  List<Rider> riders = [];
  DbConnect myDb = DbConnect();

  @override
  void initState() {
    super.initState();
    fetchRidersFromMongoDB();
  }

  void fetchRidersFromMongoDB() async {
    try {
      // Assurez-vous d'utiliser la méthode correcte pour récupérer les cavaliers depuis MongoDB
      List<Rider> fetchedRiders = (await myDb.getRiders()).cast<Rider>();

      setState(() {
        riders = fetchedRiders;
      });
    } catch (e) {
      print("Erreur lors de la récupération des cavaliers : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cavaliers'),
        actions: [
          IconButton(
            icon: Icon(Icons.add), // Bouton pour accéder à la création de cavaliers
            onPressed: () {
              Navigator.pushNamed(context, '/create_rider'); // Redirigez vers la page de création de cavaliers
            },
          ),
        ],
      ),
      body: riders.isNotEmpty
          ? ListView.builder(
        itemCount: riders.length,
        itemBuilder: (context, index) {
          Rider rider = riders[index];
          return ListTile(
            title: Text(rider.name),
            subtitle: Text('Age: ${rider.age.toString()}'),
          );
        },
      )
          : Center(
        child: Text('Aucun cavalier trouvé'), // Message si la liste est vide
      ),
    );
  }
}
