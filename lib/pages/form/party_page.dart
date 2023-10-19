import 'package:flutter/material.dart';
import 'package:flutter_mlp/widgets/navbar.dart';

class FormPartyPage extends StatelessWidget {
  const FormPartyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulaire soirée"),
        titleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: const Color.fromARGB(255, 247, 184, 247),
      ),
      body: Container(
          color: const Color.fromARGB(255, 197, 224, 255),
          child: Column(
            children: [
              const SizedBox(
                  height: 200,
                  child: Card(
                    child: Expanded(
                      child: Center(
                          child: Text(
                        'Caroussel',
                      )),
                    ),
                  )),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Card(
                        color: Colors.white,
                        child: Container(
                            height: 60,
                            margin: EdgeInsets.all(0),
                            child: const Text(
                                '(PDP) (prénom nom de linvité), au clic, invité sera ajt')),
                      ),
                    ),
                    ListTile(
                      title: Card(
                        color: Colors.white,
                        child: Container(
                            height: 60,
                            margin: EdgeInsets.all(0),
                            child: const Text(
                                '(PDP) (prénom nom de linvité), au clic, invité sera ajt')),
                      ),
                    ),
                    ListTile(
                      title: Card(
                        color: Colors.white,
                        child: Container(
                            height: 60,
                            margin: EdgeInsets.all(0),
                            child: const Text(
                                '(PDP) (prénom nom de linvité), au clic, invité sera ajt')),
                      ),
                    ),
                  ],
                ),
              ),
              FractionallySizedBox(
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          //action du formulaire ici
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 129, 68, 187)),
                        child: const Text("Créer la soirée 🎉",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20))),
                  ),
                ),
              )
            ],
          )),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
