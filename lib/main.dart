import 'package:flutter/material.dart';
import 'package:flutter_mlp/database/db_class.dart';
import 'package:flutter_mlp/pages/events_page.dart';
// import 'package:flutter_mlp/pages/home_page.dart';
import 'package:flutter_mlp/pages/profil_page.dart';
import 'package:flutter_mlp/pages/riders_page.dart';
import 'package:flutter_mlp/pages/login_page.dart';
import 'package:flutter_mlp/widgets/controllerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  DbConnect myDb = DbConnect();

  @override
  void initState() {
    super.initState();
    myDb.connectToDb();
  }

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
        '/': (context) => Login(),
        '/profil': (context) => ProfilPage(),
        '/riders': (context) => const RidersPage(),
        '/events': (context) => const EventsPage(),
        // '/register':(context) => const RegisterPage(),
        '/': (context) => const ControllerPage(),
      },
    );
  }
}
