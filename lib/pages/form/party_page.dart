import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/event.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

int repasIndex = 0;

class FormPartyPage extends StatefulWidget {
  const FormPartyPage({super.key});

  @override
  State<FormPartyPage> createState() => _FormPartyPageState();
}

class _FormPartyPageState extends State<FormPartyPage> {
  List<mongo.ObjectId>? selectedUser = [];

  List<User>? userList = [];

  DateTime _dateTime = DateTime.now();

  List disciplineType = ['Apéro', 'Repas', 'Jeu de société'];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      getAllUsers();
    });
  }

  Future<void> getAllUsers() async {
    var allUsers = await User.getAllUser();
    setState(() {
      userList = allUsers;
      print(userList);
    });
  }

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

  void verifyDouble(mongo.ObjectId? id) {
    setState(() {
      if (selectedUser!.contains(id)) {
        selectedUser!.remove(id);
      } else {
        selectedUser!.add(id!);
      }
    });
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
          child: Column(
            children: [
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
                                setState(() {
                                  repasIndex = 0;
                                });
                              },
                              child: ColorFiltered(
                                colorFilter: repasIndex == 0
                                    ? const ColorFilter.mode(
                                        Colors.transparent, BlendMode.srcOver)
                                    : const ColorFilter.mode(
                                        Colors.grey, BlendMode.saturation),
                                child: Image.asset("assets/images/apero.jpg"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  repasIndex = 1;
                                });
                              },
                              child: ColorFiltered(
                                colorFilter: repasIndex == 1
                                    ? const ColorFilter.mode(
                                        Colors.transparent, BlendMode.srcOver)
                                    : const ColorFilter.mode(
                                        Colors.grey, BlendMode.saturation),
                                child: Image.asset("assets/images/repas.jpg"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  repasIndex = 2;
                                });
                              },
                              child: ColorFiltered(
                                colorFilter: repasIndex == 2
                                    ? const ColorFilter.mode(
                                        Colors.transparent, BlendMode.srcOver)
                                    : const ColorFilter.mode(
                                        Colors.grey, BlendMode.saturation),
                                child: Image.asset("assets/images/jeu.jpg"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Card(
                        color: Colors.white,
                        child: Center(
                            child: Text(
                          disciplineType[repasIndex],
                          style: const TextStyle(fontSize: 30),
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
                              color: const Color.fromARGB(255, 247, 184, 247),
                              child: const Text('Calendrier'),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: userList?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        color: Colors.white,
                        child: SizedBox(
                            height: 60,
                            child: InkWell(
                              onTap: () {
                                verifyDouble(userList![index].id);
                              },
                              child: Row(
                                children: [
                                  Container(
                                      height: 50,
                                      width: 50,
                                      margin: const EdgeInsets.only(left: 25),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.asset(
                                          "assets/images/profil.png",
                                        ),
                                      )),
                                  Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(left: 30),
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    userList![index].firstname,
                                                    style: const TextStyle(
                                                        fontSize: 22),
                                                  ),
                                                  Text(
                                                    userList![index].lastname,
                                                    style:
                                                        TextStyle(fontSize: 22),
                                                  ),
                                                ],
                                              )))),
                                  Container(
                                    margin: const EdgeInsets.only(right: 25),
                                    child: Icon(
                                      Icons.circle,
                                      color: selectedUser!
                                              .contains(userList![index].id)
                                          ? Colors.green
                                          : Colors.redAccent,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            )
                            // prénom nom de linvité), au clic, invité sera ajt
                            ),
                      ),
                    ],
                  );
                },
              )),
              FractionallySizedBox(
                  child: SizedBox(
                      height: 50,
                      child: Center(
                          child: ElevatedButton(
                        onPressed: () {
                          var newEvent = Event(
                              type: "Soiree",
                              date: _dateTime,
                              creator: selectedUser![
                                  0], //a remplacer par l'utilisateur connecté
                              place: "Ecurie",
                              users: selectedUser!.isEmpty ? selectedUser : [],
                              horses: [],
                              discipline: disciplineType[repasIndex]);
                          newEvent.insertParty(newEvent);
                          Navigator.pop(context);
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
            ],
          ),
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
