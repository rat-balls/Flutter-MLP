import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/widgets/profil/add_horse_form.dart';
import 'package:flutter_mlp/widgets/riders/horse_list_widget.dart';
import 'package:flutter_mlp/widgets/riders/rider_list_widget.dart';

class RidersPage extends StatefulWidget {
  const RidersPage({super.key});

  @override
  State<RidersPage> createState() => _RidersPageState();
}

class _RidersPageState extends State<RidersPage> {
  late List<Horse>? allHorse = [];
  late List<User>? allUser = [];

  bool allHorseLoaded = false;
  bool allUserLoaded = false;
  bool isAdmin = false; // Variable pour suivre si l'utilisateur est administrateur

  Future<void> _getHorses() async {
    List<Horse>? horseList = await Horse.getHorses();
    setState(() {
      allHorse = horseList;
      allHorseLoaded = true;
    });
  }

  Future<void> _getUsers() async {
    List<User>? usersList = await User.getAllUser();
    print(usersList);
    setState(() {
      allUser = usersList;
      allUserLoaded = true;
    });
  }

  Future<void> _checkAdminStatus() async {
    User? currentUser = await User.getUserInfo('alice@example.com');
    print(currentUser!.isAdmin);
    setState(() {
      isAdmin = currentUser!.isAdmin;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.wait([_checkAdminStatus(), _getUsers(), _getHorses()]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        allUserLoaded
            ? RiderListWidget(
          title: "Liste des cavaliers",
          riderList: allUser!,
          isAdmin: isAdmin, // Assurez-vous d'avoir isAdmin dans l'état
          getUsers: _getUsers, // Passez la fonction de récupération des utilisateurs
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
        allHorseLoaded
            ? HorsesListWidget(
          title: "Liste des chevaux",
          horsesList: allHorse!,
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
        if (isAdmin) // Afficher quelque chose si l'utilisateur est administrateur
          const Text('L\'utilisateur est administrateur'),
      ],
    );
  }
}
