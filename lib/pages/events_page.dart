import 'package:flutter/material.dart';
import 'package:flutter_mlp/pages/form/comp_page.dart';
import 'package:flutter_mlp/pages/form/lesson_page.dart';
import 'package:flutter_mlp/pages/form/party_page.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: const Color.fromARGB(255, 197, 224, 255),
          child: Center(
              child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Card(
                        color: Color.fromARGB(255, 241, 241, 242),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const FormLessonPage(),
                              ),
                            );
                          },
                          child: const Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              'Créer un Cours 📝',
                              style: TextStyle(fontSize: 28),
                            )),
                          ),
                        ),
                      )),
                      Expanded(
                          child: Card(
                        color: Color.fromARGB(255, 241, 241, 242),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const FormCompetitionPage(),
                              ),
                            );
                          },
                          child: const Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              'Créer une Compétition 🏆',
                              style: TextStyle(fontSize: 28),
                            )),
                          ),
                        ),
                      )),
                      Expanded(
                          child: Card(
                        color: Color.fromARGB(255, 241, 241, 242),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const FormPartyPage(),
                              ),
                            );
                          },
                          child: const Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                'Créer une Soirée 🎉',
                                style: TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  )))),
    );
  }
}
