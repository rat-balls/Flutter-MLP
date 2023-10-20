import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/pages/events_page.dart';
import 'package:flutter_mlp/pages/home_page.dart';
import 'package:flutter_mlp/pages/login_page.dart';
import 'package:flutter_mlp/pages/profil_page.dart';
import 'package:flutter_mlp/pages/riders_page.dart';
import 'package:flutter_mlp/pages/timeline_page.dart';
import 'package:flutter_mlp/pages/login_page.dart';

import '../class/app_colors.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<ControllerPage> {
  var logged = false;

  int _currentIndex = 0;

  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !User.isAuthenticated
              ? Text('MLP')
              : [
                  const Text(
                    "Accueil",
                    style: TextStyle(fontSize: 25),
                  ),
                  const Text(
                    "Créer des évènements",
                    style: TextStyle(fontSize: 25),
                  ),
                  const Text(
                    "Liste des cavalier et chevaux",
                    style: TextStyle(fontSize: 25),
                  ),
                  const Text(
                    "Calendrier",
                    style: TextStyle(fontSize: 25),
                  ),
                  const Text(
                    "Profil",
                    style: TextStyle(fontSize: 25),
                  ),
                ][_currentIndex],
          titleTextStyle: const TextStyle(fontSize: 18),
          backgroundColor: const Color.fromARGB(255, 247, 184, 247),
        ),
        body: !User.isAuthenticated
            ? LoginPage()
            : [
                const HomePage(),
                const EventsPage(),
                const RidersPage(),
                const TimelineCalendarPage(),
                ProfilPage(),
              ][_currentIndex],
        bottomNavigationBar: !User.isAuthenticated
            ? null
            : Container(
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  selectedItemColor: AppColors().selectedItemColor,
                  unselectedItemColor: AppColors().unselectedItemColor,
                  backgroundColor: AppColors().bgColor,
                  onTap: (index) => setCurrentIndex(index),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.pages),
                      label: 'Event',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bedroom_baby),
                      label: 'List',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_month),
                      label: 'Calendar',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.man),
                      label: 'Profil',
                    ),
                    // Ajoutez d'autres éléments pour les autres onglets de la barre de navigation ici
                  ],
                ),
              ));
  }
}
