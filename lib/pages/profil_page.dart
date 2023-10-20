import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/class/user_profil/user_profil.dart';
import 'package:flutter_mlp/widgets/profil/add_horse_form.dart';
import 'package:flutter_mlp/widgets/profil/section_widget.dart';
import 'package:flutter_mlp/widgets/profil/user_card.dart';

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
    User? userInfo = await User.getUserInfo('alice@example.com');
    setState(() {
      _user = userInfo;
      _userDataLoaded = true;
    });
  }

  Future<void> _getHorses() async {
    List<Horse>? horseList = await Horse.getNonOwnedHorses(_user!.id);
    setState(() {
      _horseList = horseList;
      _horsesDataLoaded = true;
    });
  }

  Future<void> _getOwnedHorses() async {
    List<Horse>? ownedList = await User.getOwnedHorses(_user!.id);
    setState(() {
      _ownedHorsesList = ownedList;
      _ownedHorsesDataLoaded = true;
    });
  }

  Future<void> _getUserHorsesDp() async {
    List<Horse>? dpList = await User.getHorsesInDpList(_user!.id);
    setState(() {
      _userHorsesDp = dpList;
      _userHorsesDpDataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
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
                  UserCard(user: _user!),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const ContinuousRectangleBorder(),
                          backgroundColor:
                              const Color.fromARGB(255, 247, 184, 247)),
                      onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Modification du profil"),
                                content: AddHorseForm(
                                  user: _user!,
                                ),
                              );
                            },
                          ),
                      child: const Text("Ajouter un cheval")),
                  SectionWidget(
                    title: "Mes Chevaux",
                    dataLoaded: _ownedHorsesDataLoaded,
                    horseList: _ownedHorsesList!,
                    user: _user!,
                  ),
                  SectionWidget(
                    title: "Mes DP",
                    dataLoaded: _userHorsesDpDataLoaded,
                    horseList: _userHorsesDp!,
                    user: _user!,
                  ),
                  SectionWidget(
                    title: "Les chevaux",
                    dataLoaded: _horsesDataLoaded,
                    horseList: _horseList!,
                    user: _user!,
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
