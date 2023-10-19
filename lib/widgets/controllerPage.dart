import 'package:flutter/material.dart';
import 'package:flutter_mlp/pages/events_page.dart';
import 'package:flutter_mlp/pages/home_page.dart';
import 'package:flutter_mlp/pages/profil_page.dart';
import 'package:flutter_mlp/pages/riders_page.dart';
import 'package:flutter_mlp/pages/calendar_page.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

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
          title: const Text("Ajouter un évènement"),
          titleTextStyle: const TextStyle(fontSize: 18),
          backgroundColor: const Color.fromARGB(255, 247, 184, 247),
        ),
        body: [
          HomePage(),
          EventsPage(),
          RidersPage(),
          CalendarPage(),
          ProfilPage()
        ][_currentIndex],
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: const Color.fromARGB(255, 160, 0, 218),
            unselectedItemColor: const Color.fromARGB(255, 255, 240, 240),
            backgroundColor: const Color.fromARGB(255, 247, 184, 247),
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
