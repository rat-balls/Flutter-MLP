import 'package:flutter/material.dart';
import 'package:flutter_mlp/pages/events_page.dart';
import 'package:flutter_mlp/widgets/navbar.dart';

class FormPartyPage extends StatelessWidget {
  const FormPartyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulaire soirée"),
        titleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: const Color.fromARGB(255, 247, 184, 247),
      ),
      body: Container(
        child: Center(child: Text('Formulaire soirée')),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
