import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/user_profil/horse.dart';
import 'package:flutter_mlp/class/user_profil/user.dart';
import 'package:flutter_mlp/class/user_profil/user_profil.dart';
import 'package:flutter_mlp/widgets/edit_horse_form.dart';
import 'package:flutter_mlp/widgets/edit_user_form.dart';
import 'package:flutter_mlp/widgets/horse_card.dart';
import 'package:flutter_mlp/widgets/horses_list.dart';

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
    await userProfil.getUserInfo('email@edu.esiee-it.fr');
    setState(() {
      _user = userProfil.currentUser;
      _userDataLoaded = true;
    });
  }

  Future<void> _getHorses() async {
    await userProfil.getHorses();
    setState(() {
      _horseList = userProfil.horsesList;
      _horsesDataLoaded = true;
    });
  }

  Future<void> _getOwnedHorses() async {
    await userProfil.getOwnedHorses(_user?.id);
    setState(() {
      _ownedHorsesList = userProfil.ownedHorsesList;
      _ownedHorsesDataLoaded = true;
    });
  }

  Future<void> _getUserHorsesDp() async {
    await userProfil.getHorsesInDpList(_user?.id);
    setState(() {
      _userHorsesDp = userProfil.userHorsesDp;
      _userHorsesDpDataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      await _getUserInfo();
      await _getHorses();
      await _getOwnedHorses();
      await _getUserHorsesDp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil page")),
      body: _userDataLoaded && _horsesDataLoaded
          ? Column(
              children: [
                Row(
                  children: [
                    Image(image: AssetImage(pp), width: 50, height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(_user!.firstname),
                            Text(_user!.lastname)
                          ],
                        ),
                        Text(_user!.age),
                        Text(_user!.phonenumbers),
                        Text(_user!.email),
                        Text(_user!.ffe)
                      ],
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Modifications des informations"),
                        content: EditUserForm(user: _user!),
                      );
                    },
                  ),
                  child: const Text("Modifier mon profil"),
                ),
                const Text("Mes chevaux"),
                _ownedHorsesDataLoaded && _userDataLoaded
                    ? HorseListWidget(
                        userId: _user!.id, horseList: _ownedHorsesList)
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                const Text("Mes DP"),
                _userHorsesDpDataLoaded && _userDataLoaded
                    ? HorseListWidget(
                        userId: _user!.id, horseList: _userHorsesDp)
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                const Text("S'associer à un cheval"),
                _horsesDataLoaded && _userDataLoaded
                    ? HorseListWidget(userId: _user!.id, horseList: _horseList)
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
