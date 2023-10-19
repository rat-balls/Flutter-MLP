import 'package:flutter/material.dart';
import 'package:flutter_mlp/pages/events_page.dart';
import 'package:flutter_mlp/pages/home_page.dart';
import 'package:flutter_mlp/pages/profil_page.dart';
import 'package:flutter_mlp/pages/riders_page.dart';
import 'package:flutter_mlp/pages/calendar_page.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: const Color.fromARGB(255, 247, 184, 247),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromARGB(255, 160, 0, 218),
          unselectedItemColor: const Color.fromARGB(255, 255, 240, 240),
          backgroundColor: const Color.fromARGB(255, 247, 184, 247),
          onTap: (value) {
            if (value == 0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
            if (value == 1) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EventsPage(),
                ),
              );
            }
            if (value == 2) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RidersPage(),
                ),
              );
            }
            if (value == 3) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CalendarPage(),
                ),
              );
            }
            if (value == 4) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfilPage(),
                ),
              );
            }
          },
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
          ]),
    );
  }
}
