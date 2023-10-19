import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mlp/class/event.dart';
import 'package:flutter_mlp/class/users/user.dart';

class FormLessonPage extends StatefulWidget {
  const FormLessonPage({super.key});

  @override
  State<FormLessonPage> createState() => _FormLessonPageState();
}

class _FormLessonPageState extends State<FormLessonPage> {
  getUser(str) async {
    User userInfo = await User.getUserInfo(str) as User;
  }

  int? _sliding = 0;

  int indexPlace = 0;
  int indexDiscipline = 0;

  List listDiscipline = ['Dressage', "Saut d'obstacle", 'Endurance'];

  List listPlace = [
    "Carrière",
    "Manège",
  ];

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
        title: const Text("Formulaire cours"),
        titleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: const Color.fromARGB(255, 247, 184, 247),
      ),
      body: Container(
        color: const Color.fromARGB(255, 197, 224, 255),
        child: Column(children: [
          CupertinoSlidingSegmentedControl(
            children: {
              0: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 80,
                      child: const Center(
                        child: Text(
                          'Dressage',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              1: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 80,
                      child: const Center(
                        child: Text(
                          "Saut d'obstacle",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              2: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 80,
                      child: const Center(
                        child: Text(
                          'Endurance',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            },
            groupValue: _sliding,
            onValueChanged: (int? newValue) {
              setState(
                () {
                  _sliding = newValue;
                  if (_sliding == 0) {
                    indexDiscipline = 0;
                  } else if (_sliding == 1) {
                    indexDiscipline = 1;
                  } else {
                    indexDiscipline = 2;
                  }
                },
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        indexPlace = 0;
                      });
                    },
                    child: Image.asset(
                      "assets/images/exterior.jpg",
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        indexPlace = 1;
                      });
                    },
                    child: Image.asset(
                      "assets/images/interior.jpg",
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
                listPlace[indexPlace],
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
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
              )),
          Expanded(
              child: Container(
            child: const Center(
                child: Text('Liste cv associé a la discipline select')),
          )),
          FractionallySizedBox(
              child: SizedBox(
                  height: 50,
                  child: Center(
                      child: ElevatedButton(
                    onPressed: () {
                      var userInfo;
                      var newEvent = Event(
                          type: "Cours",
                          date: _dateTime,
                          creator: getUser('alice@example.com'),
                          place: listPlace[indexPlace],
                          discipline: listDiscipline[indexDiscipline]);
                      newEvent.insertLesson(newEvent);
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const SizedBox(
                        width: 150,
                        height: 25,
                        child: Center(
                            child: Text(
                          'Créer le cours 📝',
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
      ),
    );
  }
}
