import 'package:flutter/material.dart';

import 'package:flutter_mlp/widgets/navbar.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ajouter un évènement"),
          titleTextStyle: const TextStyle(fontSize: 18),
          backgroundColor: const Color.fromARGB(255, 247, 184, 247),
        ),
        body: const Column(
          children: [
            Card(
              child: Text('test'),
            )
          ],
        ),

        //BARRE DE NAVIGATION
        //--------------------------------------------
        bottomNavigationBar: const CustomBottomNavigationBar()
        //BARRE DE NAVIGATION
        //--------------------------------------------
        );
  }
}
