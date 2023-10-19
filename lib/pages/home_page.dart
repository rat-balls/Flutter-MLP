import 'package:flutter/material.dart';
import 'package:flutter_mlp/pages/riders_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenue sur la page d\'accueil !',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20), // Espacement
            ElevatedButton(
              onPressed: () {
                // Utilisez la navigation pour accéder à la liste des cavaliers
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RidersPage()),
                );
              },
              child: Text('Voir la liste des Cavaliers'),
            ),
          ],
        ),
      ),
    );
  }
}
