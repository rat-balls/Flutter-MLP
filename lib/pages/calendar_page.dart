import 'package:flutter/material.dart';
import 'package:flutter_mlp/widgets/navbar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Calendrier')),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
