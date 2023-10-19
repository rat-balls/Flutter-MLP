import 'package:flutter/material.dart';
import 'package:flutter_mlp/pages/events_page.dart';
import 'package:flutter_mlp/pages/profil_page.dart';
import 'package:flutter_mlp/class/rider.dart'; // Assurez-vous que le chemin est correct
import 'package:flutter_mlp/pages/riders_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecurie MLP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RidersPage(),
        '/profil': (context) => const ProfilPage(),
        '/events': (context) => const EventsPage(),
      },
    );
  }
}
