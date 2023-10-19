import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/class/user_profil/user_profil.dart';
import 'package:flutter_mlp/database/db_class.dart';
import 'package:provider/provider.dart';

class EditUserForm extends StatefulWidget {
  const EditUserForm({super.key, required this.user});
  final User user;

  @override
  State<EditUserForm> createState() => _EditUserForm();
}

class _EditUserForm extends State<EditUserForm> {
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var ageController = TextEditingController();
  var phonenumberController = TextEditingController();
  var ffeController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstnameController.text = widget.user.firstname;
    lastnameController.text = widget.user.lastname;
    ageController.text = widget.user.age;
    phonenumberController.text = widget.user.phonenumbers;
    ffeController.text = widget.user.ffe;
    emailController.text = widget.user.email;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: firstnameController,
              decoration: const InputDecoration(label: Text("Prénom")),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez renseigner un prénom";
                }
                return null;
              },
            ),
            TextFormField(
              controller: lastnameController,
              decoration: const InputDecoration(label: Text("Nom")),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez renseigner un nom";
                }
                return null;
              },
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(label: Text("Âge")),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez renseigner un âge";
                }
                return null;
              },
            ),
            TextFormField(
              controller: phonenumberController,
              decoration:
                  const InputDecoration(label: Text("Numéro de téléphone")),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez renseigner un numéro de téléphone";
                }
                return null;
              },
            ),
            TextFormField(
              controller: ffeController,
              decoration: const InputDecoration(label: Text("Lien FFE")),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez renseigner un lien FFE";
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(label: Text("Email")),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez renseigner un Email";
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  User.updateUserInfo(User(
                      firstname: firstnameController.text,
                      lastname: lastnameController.text,
                      age: ageController.text,
                      phonenumbers: phonenumberController.text,
                      ffe: ffeController.text,
                      email: emailController.text));
                }
              },
              child: const Text("Modifier"),
            ),
          ],
        ));
  }
}
