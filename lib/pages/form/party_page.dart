import 'package:flutter/material.dart';
import 'package:flutter_mlp/widgets/navbar.dart';

int repasIndex = 0;

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
              SizedBox(
                height: 200,
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
                        )))
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
                            height: 80,
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Container(
                                      height: 65,
                                      width: 65,
                                      margin: const EdgeInsets.only(left: 25),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
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
                            height: 80,
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Container(
                                      height: 65,
                                      width: 65,
                                      margin: const EdgeInsets.only(left: 25),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
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
