import 'package:flutter/material.dart';
import 'package:flutter_mlp/widgets/navbar_sous_page.dart';

class FormLessonPage extends StatelessWidget {
  const FormLessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulaire cours"),
        titleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: const Color.fromARGB(255, 247, 184, 247),
      ),
      body: Container(
        color: const Color.fromARGB(255, 197, 224, 255),
        child: const Center(child: Text('Formulaire cours')),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
