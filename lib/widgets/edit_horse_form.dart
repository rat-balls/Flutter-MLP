import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/user_profil/user_profil.dart';

class EditHorseForm extends StatefulWidget {
  const EditHorseForm({Key? key, required this.horse}) : super(key: key);
  final Horse horse;

  @override
  State<EditHorseForm> createState() => _EditHorseFormState();
}

class _EditHorseFormState extends State<EditHorseForm> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var coatController = TextEditingController();
  var breedController = TextEditingController();
  var genderController = TextEditingController();
  var specialtiesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.horse.name;
    ageController.text = widget.horse.age.toString();
    coatController.text = widget.horse.coat;
    breedController.text = widget.horse.breed;
    genderController.text = widget.horse.gender;
    specialtiesController.text = widget.horse.specialties.join(', ');
  }

  final _formKey = GlobalKey<FormState>();

  var userProfil = UserProfil();

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
                final updatedHorse = Horse(
                  id: widget.horse.id,
                  name: nameController.text,
                  age: int.parse(ageController.text),
                  coat: coatController.text,
                  breed: breedController.text,
                  gender: genderController.text,
                  specialties: specialtiesController.text
                      .split(',')
                      .map((e) => e.trim())
                      .toList(),
                );
                Horse.updateHorseInfo(updatedHorse);
              }
            },
            child: const Text('Modifier'),
          ),
        ],
      ),
    );
  }
}
