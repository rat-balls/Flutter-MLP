import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<User> users = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var ageController = TextEditingController();
  var ffeController = TextEditingController();
  var emailController = TextEditingController();
  var phonenumberController = TextEditingController();
  var passwordController = TextEditingController();
  // pp

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: lastnameController,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextFormField(
              controller: firstnameController,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              decoration: InputDecoration(labelText: 'Prénom'),
            ),
            TextFormField(
              controller: ageController,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextFormField(
              controller: ffeController,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              decoration: InputDecoration(labelText: 'Lien FFE'),
            ),
            TextFormField(
              controller: phonenumberController,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              decoration: InputDecoration(labelText: 'Numero de telephone'),
            ),
            TextFormField(
              controller: emailController,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              decoration: InputDecoration(labelText: 'Mot de passe'),
            ),
            ElevatedButton(
              onPressed: () {
                           User newUser = User(
                    firstname: firstnameController.text,
                    lastname: lastnameController.text,
                    age: ageController.text,
                    phonenumbers: phonenumberController.text,
                    ffe: ffeController.text,
                    email: emailController.text);

                    newUser.userRegister(newUser);
              },
              child: Text('Inscription'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => LoginPage()),
                // );
              },
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
