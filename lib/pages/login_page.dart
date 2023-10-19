import 'package:flutter_mlp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mlp/pages/profil_page.dart';
import 'package:flutter_mlp/pages/register_page.dart';
import 'package:flutter_mlp/database/db_class.dart';
import 'package:mongo_dart/mongo_dart.dart';


class Login extends StatelessWidget{
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Connexion')),
        body: Column(
          children: <Widget>[
            LoginPage(),
            Buttons(),
          ],)
      ),
    );
  }
}



class LoginPage extends StatelessWidget{
  LoginPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
            ),
          ]);
    }
}



class Buttons extends StatelessWidget{
  Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            tooltip: 'Se connecter',
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            tooltip: 'Creer un compte',
          )
        ],
      );
  }
}

/*
class ValidateButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final DbConnect dbConnect;

  ValidateButton({Key? key, required this.usernameController, required this.passwordController, required this.dbConnect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () async {
          bool isAuthenticated = await dbConnect.LoginUser(
            usernameController.text,
            passwordController.text
          );

          if (isAuthenticated) {
            Navigator.pushReplacement(  // Use pushReplacement to replace the current route with the new one
              context,
              MaterialPageRoute(builder: (context) => ProfilPage()),  // Redirect to the profile page or the main home page of your app
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Nom d\'utilisateur ou mot de passe incorrect')),
            );
          }
        },
        child: Text('Valider'),
      ),
    );
  }
}*/

