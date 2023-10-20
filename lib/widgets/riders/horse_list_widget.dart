import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/widgets/controllerPage.dart';
import 'package:flutter_mlp/widgets/profil/edit_horse_form.dart';

class HorsesListWidget extends StatelessWidget {
  HorsesListWidget({
    super.key,
    required this.title,
    required this.horsesList,
  });
  String title;
  List<Horse> horsesList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: horsesList.map((horse) {
                    return Card(
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${horse.name}"),
                              Text("${horse.age} ans"),
                              Text(
                                  "Spécialités: ${horse.specialties.join(', ')}")
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
