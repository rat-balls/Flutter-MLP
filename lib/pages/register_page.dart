import 'package:flutter/material.dart';
import 'package:flutter_mlp/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<User> users = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = '';
  String firstname = '';
  String age ='';
  String ffe = '';
  String mail = '';
  String number = '';
  String role = '';
  String password = '';
  // pp

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      
      body:
        Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  onChanged: (value) => name = value,
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  decoration: InputDecoration(labelText: 'Nom'),
                ),
                TextFormField(
                  onChanged: (value) => firstname = value,
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  decoration: InputDecoration(labelText: 'Prénom'),
                ),
                  TextFormField(
                  onChanged: (value) => age = value,
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  decoration: InputDecoration(labelText: 'Age'),
                ),
                  TextFormField(
                  onChanged: (value) => ffe = value,
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  decoration: InputDecoration(labelText: 'Lien FFE'),
                ),
                TextFormField(
                  onChanged: (value) => role= value,
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  decoration: InputDecoration(labelText: 'Role'),
                ),
                TextFormField(
                  onChanged: (value) => mail = value,
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                  TextFormField(
                  onChanged: (value) => password = value,
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  decoration: InputDecoration(labelText: 'Mot de passe'),
                ),
                   ElevatedButton(
                onPressed: () {

                  },
                  child: Text('Inscription'),
                ),
                TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Se connecter'),
                ), 
              ],
            ),
          ),
          
    );
    
  }
}



class User {
  final String name;
  final String firstname;
  final String role;
  final String mail;

  User({required this.name, required this.firstname, required this.role, required this.mail});
}

