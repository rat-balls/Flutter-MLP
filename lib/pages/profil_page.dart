import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/class/user_profil/user_profil.dart';
import 'package:flutter_mlp/widgets/profil/add_horse_form.dart';
import 'package:flutter_mlp/widgets/profil/edit_horse_form.dart';
import 'package:flutter_mlp/widgets/profil/edit_user_form.dart';
import 'package:flutter_mlp/widgets/profil/horse_card.dart';
import 'package:flutter_mlp/widgets/profil/horses_list.dart';

class ProfilPage extends StatefulWidget {
  ProfilPage({super.key});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late User? _user;
  late List<Horse>? _horseList;
  late List<Horse>? _ownedHorsesList;
  late List<Horse>? _userHorsesDp;

  var userProfil = UserProfil();
  var pp = "assets/images/images-1.jpg";

  bool _userDataLoaded = false;
  bool _horsesDataLoaded = false;
  bool _ownedHorsesDataLoaded = false;
  bool _userHorsesDpDataLoaded = false;

  Future<void> _getUserInfo() async {
    User? userInfo = await User.getUserInfo('bob@example.com');
    setState(() {
      _user = userInfo;
      _userDataLoaded = true;
    });
  }

  Future<void> _getHorses() async {
    List<Horse>? horseList = await Horse.getHorses();
    setState(() {
      _horseList = horseList;
      _horsesDataLoaded = true;
    });
  }

  Future<void> _getOwnedHorses() async {
    List<Horse>? ownedList = await User.getOwnedHorses(_user?.id);
    setState(() {
      _ownedHorsesList = ownedList;
      _ownedHorsesDataLoaded = true;
    });
  }

  Future<void> _getUserHorsesDp() async {
    List<Horse>? dpList = await User.getHorsesInDpList(_user?.id);
    setState(() {
      _userHorsesDp = dpList;
      _userHorsesDpDataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () async {
      await _getUserInfo();
      await _getHorses();
      await _getOwnedHorses();
      await _getUserHorsesDp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _userDataLoaded &&
                _horsesDataLoaded &&
                _ownedHorsesDataLoaded &&
                _userHorsesDpDataLoaded
            ? ListView(
                children: [
                  _Section(
                      "Mes Chevaux", _ownedHorsesDataLoaded, _ownedHorsesList!),
                  _Section("Mes DP", _userHorsesDpDataLoaded, _userHorsesDp!),
                  _Section("Les Chevaux", _horsesDataLoaded, _horseList!),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  Widget _Section(String title, bool dataLoaded, List<Horse> horseList) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          dataLoaded
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: horseList.map((horse) {
                      return Card(
                        child: Column(
                          children: [
                            Text(
                              horse.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Âge: ${horse.age} ans"),
                            Text("Robe: ${horse.coat}"),
                            Text("Race: ${horse.breed}"),
                            Text("Sexe: ${horse.gender}"),
                            Text(
                                "Spécialités: ${horse.specialties.join(', ')}"),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    User.associateUserWithHorse(
                                        horse.id, _user!.id);
                                  },
                                  child: const Text("S'associer à un cheval"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    User.addUserToHorseDp(horse.id, _user!.id);
                                  },
                                  child: const Text("Se mettre en DP"),
                                ),
                                ElevatedButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Modifier le cheval"),
                                        content: EditHorseForm(
                                          horse: horse,
                                        ),
                                      );
                                    },
                                  ),
                                  child: const Text("Modifier le cheval"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
