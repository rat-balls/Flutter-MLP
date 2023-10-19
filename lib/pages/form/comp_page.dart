import 'package:flutter/material.dart';

class FormCompetitionPage extends StatelessWidget {
  const FormCompetitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulaire compétition"),
        titleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: const Color.fromARGB(255, 247, 184, 247),
      ),
      body: Container(
        color: const Color.fromARGB(255, 197, 224, 255),
        child: const Center(child: Text('Formulaire compétition')),
      ),
    );
  }
}
