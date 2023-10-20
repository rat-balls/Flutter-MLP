import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/event.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class FormCompetitionPage extends StatefulWidget {
  const FormCompetitionPage({super.key});

  @override
  State<FormCompetitionPage> createState() => _FormCompetitionPageState();
}

class _FormCompetitionPageState extends State<FormCompetitionPage> {
  DateTime _dateTime = DateTime.now();

  List<mongo.ObjectId>? selectedUser = [];

  List<User>? userList = [];

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

  String _name = "";
  String _adress = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Créer une compétition"),
        titleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: const Color.fromARGB(255, 247, 184, 247),
      ),
      body: Container(
        color: const Color.fromARGB(255, 197, 224, 255),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Text(
                    _name.isEmpty ? "Ma compétition" : _name,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 218, 151, 7),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 150,
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Image.asset('assets/images/trophy.png'),
                    ),
                  ),
                  Text(
                    DateFormat('EEE d MMM').format(_dateTime),
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 218, 151, 7),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: TextFormField(
                        onChanged: (value) => setState(() {
                          _name = value;
                        }),
                        validator: (value) =>
                            value!.isEmpty ? "champ requis" : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nom de la compétition',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        _showDatePiker();
                      },
                      color: const Color.fromARGB(255, 247, 184, 247),
                      child: const Text('Calendrier'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 38,
                child: TextFormField(
                  onChanged: (value) => _adress = value,
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adresse',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
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
                                            margin:
                                                const EdgeInsets.only(left: 25),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Image.asset(
                                                "assets/images/margot.jpeg",
                                              ),
                                            )),
                                        Expanded(
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 30),
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 30),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          userList![index]
                                                              .firstname,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 22),
                                                        ),
                                                        Text(
                                                          userList![index]
                                                              .lastname,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 22),
                                                        ),
                                                      ],
                                                    )))),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 25),
                                          child: Icon(
                                            Icons.circle,
                                            color: selectedUser!.contains(
                                                    userList![index].id)
                                                ? Colors.green
                                                : Colors.redAccent,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                  // prénom nom de linvité), au clic, invité sera ajt
                                  )),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                var newEvent = Event(
                    type: "Competition",
                    date: _dateTime,
                    creator: mongo.ObjectId.fromHexString(
                        '65312da9f80d5aa0c3badc89'),
                    users: selectedUser!.isEmpty ? selectedUser : [],
                    place: _adress,
                    horses: [],
                    discipline: _name.isEmpty ? "Ma Compétition" : _name);
                newEvent.insertCompetition(newEvent);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const SizedBox(
                  width: 150,
                  height: 25,
                  child: Center(
                      child: Text(
                    'Créer compétition 🏆',
                    style: TextStyle(color: Colors.white),
                  ))),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 197, 224, 255),
          child: Column(
            children: [
              ElevatedButton(
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
              ),
            ],
          )),
    );
  }
}
