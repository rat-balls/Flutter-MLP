import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class AddHorseForm extends StatefulWidget {
  const AddHorseForm({required this.user, super.key});
  final User user;

  @override
  State<AddHorseForm> createState() => _AddHorseFormState();
}

class _AddHorseFormState extends State<AddHorseForm> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var coatController = TextEditingController();
  var breedController = TextEditingController();
  var genderController = TextEditingController();
  var specialtiesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Nom'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez renseigner un nom';
              }
              return null;
            },
          ),
          TextFormField(
            controller: ageController,
            decoration: const InputDecoration(labelText: 'Âge'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez renseigner un âge';
              }
              return null;
            },
          ),
          TextFormField(
            controller: coatController,
            decoration: const InputDecoration(labelText: 'Robe'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez renseigner une robe';
              }
              return null;
            },
          ),
          TextFormField(
            controller: breedController,
            decoration: const InputDecoration(labelText: 'Race'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez renseigner une race';
              }
              return null;
            },
          ),
          TextFormField(
            controller: genderController,
            decoration: const InputDecoration(labelText: 'Sexe'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez renseigner un sexe';
              }
              return null;
            },
          ),
          TextFormField(
            controller: specialtiesController,
            decoration: const InputDecoration(labelText: 'Spécialités'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez renseigner des spécialités';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newHorse = Horse(
                  name: nameController.text,
                  age: int.parse(ageController.text),
                  coat: coatController.text,
                  breed: breedController.text,
                  gender: genderController.text,
                  owner: widget.user.id,
                  dp: [],
                  specialties: specialtiesController.text
                      .split(',')
                      .map((e) => e.trim())
                      .toList(),
                );
                Horse.addHorse(newHorse);
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}
