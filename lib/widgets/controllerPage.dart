import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mlp/pages/events_page.dart';
import 'package:flutter_mlp/pages/home_page.dart';
import 'package:flutter_mlp/pages/profil_page.dart';
import 'package:flutter_mlp/pages/riders_page.dart';
import 'package:flutter_mlp/pages/timeline_page.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});
  static const Color _selectedItemColor = Color.fromARGB(255, 160, 0, 218);
  static const Color _unselectedItemColor = Color.fromARGB(255, 255, 240, 240);
  static const Color _bgColor = Color.fromARGB(255, 247, 184, 247);

  @override
  State<ControllerPage> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<ControllerPage> {
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
          title: [
            const Text("Accueil"),
            const Text("Créer des évènements"),
            const Text("Liste des cavalier et chevaux"),
            const Text("Calendrier"),
            const Text("Profil"),
          ][_currentIndex],
          titleTextStyle: const TextStyle(fontSize: 18),
          backgroundColor: const Color.fromARGB(255, 247, 184, 247),
        ),
        body: [
          const HomePage(),
          const EventsPage(),
          const RidersPage(),
          const TimelineCalendarPage(),
          ProfilPage(),
        ][_currentIndex],
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: ControllerPage._selectedItemColor,
            unselectedItemColor: ControllerPage._unselectedItemColor,
            backgroundColor: ControllerPage._bgColor,
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
