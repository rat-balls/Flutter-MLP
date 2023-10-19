import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int repasIndex = 0;

class FormPartyPage extends StatefulWidget {
  const FormPartyPage({super.key});

  @override
  State<FormPartyPage> createState() => _FormPartyPageState();
}

class _FormPartyPageState extends State<FormPartyPage> {
  DateTime _dateTime = DateTime.now();

  void _showDatePiker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((value) => setState(() {
              _dateTime = value!;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ajouter un évènement"),
          titleTextStyle: const TextStyle(fontSize: 18),
          backgroundColor: const Color.fromARGB(255, 247, 184, 247),
        ),
        body: Container(
          color: const Color.fromARGB(255, 197, 224, 255),
          child: Column(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Card(
                              child: InkWell(
                                  onTap: () {
                                    repasIndex = 1;
                                  },
                                  child: Image.asset(
                                    "assets/images/apero.jpg",
                                  )))),
                      Expanded(
                          child: Card(
                              child: InkWell(
                                  onTap: () {
                                    repasIndex = 2;
                                  },
                                  child: Image.asset(
                                    "assets/images/repas.jpg",
                                  )))),
                      Expanded(
                          child: Card(
                              child: InkWell(
                                  onTap: () {
                                    repasIndex = 3;
                                  },
                                  child: Image.asset(
                                    "assets/images/jeu.jpg",
                                  )))),
                    ],
                  ),
                  const Card(
                      color: Colors.white,
                      child: Center(
                          child: Text(
                        "Repas",
                        style: TextStyle(fontSize: 30),
                      ))),
                  Card(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            DateFormat('EEE d MMM').format(_dateTime),
                            style: const TextStyle(fontSize: 18),
                          ),
                          MaterialButton(
                            onPressed: () {
                              _showDatePiker();
                            },
                            child: const Text('Calendrier'),
                            color: const Color.fromARGB(255, 247, 184, 247),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Card(
                      color: Colors.white,
                      child: SizedBox(
                          height: 60,
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    margin: const EdgeInsets.only(left: 25),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset(
                                        "assets/images/margot.jpeg",
                                      ),
                                    )),
                                const Expanded(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Margot",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Text(
                                      "Robbie",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ],
                                )),
                                Container(
                                  margin: const EdgeInsets.only(right: 25),
                                  child: const Icon(
                                    Icons.circle,
                                    color: Colors.redAccent,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          )
                          // prénom nom de linvité), au clic, invité sera ajt
                          ),
                    ),
                  ),
                  ListTile(
                    title: Card(
                      color: Colors.white,
                      child: SizedBox(
                          height: 60,
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    margin: const EdgeInsets.only(left: 25),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset(
                                        "assets/images/margot.jpeg",
                                      ),
                                    )),
                                const Expanded(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Margot",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Text(
                                      "Robbie",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ],
                                )),
                                Container(
                                  margin: const EdgeInsets.only(right: 25),
                                  child: const Icon(
                                    Icons.circle,
                                    color: Colors.redAccent,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          )
                          // prénom nom de linvité), au clic, invité sera ajt
                          ),
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
                        print("création soirée");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: const SizedBox(
                          width: 150,
                          height: 25,
                          child: Center(
                              child: Text(
                            'Créer la soirée 🎉',
                            style: TextStyle(
                                color: Color.fromARGB(255, 42, 152, 203)),
                          ))),
                    )))),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 197, 224, 255),
          child: Center(
              child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const SizedBox(
                width: 150,
                height: 25,
                child: Center(
                    child: Text(
                  'Annuler',
                  style: TextStyle(color: Colors.white),
                ))),
          )),
        ));
  }
}

/*ElevatedButton(
                      onPressed: () {
                        //action du formulaire ici
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 129, 68, 187)),
                      child: const Text("Créer la soirée 🎉",
                          style: TextStyle(color: Colors.white, fontSize: 20))),

                          */