import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/widgets/controllerPage.dart';
import 'package:flutter_mlp/widgets/profil/edit_horse_form.dart';

class SectionWidget extends StatelessWidget {
  SectionWidget(
      {super.key,
      required this.title,
      required this.dataLoaded,
      required this.horseList,
      required this.user});
  String title;
  bool dataLoaded;
  List<Horse> horseList;
  User user;

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
              dataLoaded
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: horseList.map((horse) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 350,
                                child: Card(
                                  color: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  elevation: 10,
                                  shadowColor: Color.fromARGB(125, 160, 0, 218),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          horse.breed.toUpperCase(),
                                          style:
                                              const TextStyle(letterSpacing: 2),
                                        ),
                                        Text(
                                          horse.name.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Row(
                                          children: [
                                            Text("${horse.age} ans"),
                                            const SizedBox(width: 10),
                                            Text("Robe: ${horse.coat}"),
                                            const SizedBox(width: 10),
                                            Text("Sexe: ${horse.gender}"),
                                          ],
                                        ),
                                        Text(
                                            "Spécialités: ${horse.specialties.join(', ')}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            if (!horse.isUserIsOwner(user.id))
                                              OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    foregroundColor:
                                                        const Color.fromARGB(
                                                            255, 160, 0, 218),
                                                    side: const BorderSide(
                                                        width: 1.0,
                                                        color: Color.fromARGB(
                                                            255, 160, 0, 218))),
                                                onPressed: () {
                                                  User.associateUserWithHorse(
                                                      horse.id, user.id);
                                                },
                                                child: const Text("Acheter"),
                                              ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            if (!horse.isUserIsOwner(user.id) &&
                                                !horse.isUserInDp(user.id))
                                              OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    foregroundColor:
                                                        const Color.fromARGB(
                                                            255, 160, 0, 218),
                                                    side: const BorderSide(
                                                        width: 1.0,
                                                        color: Color.fromARGB(
                                                            255, 160, 0, 218))),
                                                onPressed: () {
                                                  User.addUserToHorseDp(
                                                      horse.id, user.id);
                                                },
                                                child: const Text("Louer"),
                                              ),
                                            if (horse.isUserIsOwner(user.id))
                                              OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    foregroundColor:
                                                        const Color.fromARGB(
                                                            255, 160, 0, 218),
                                                    side: const BorderSide(
                                                        width: 1.0,
                                                        color: Color.fromARGB(
                                                            255, 160, 0, 218))),
                                                onPressed: () => showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Modifier le cheval"),
                                                      content: EditHorseForm(
                                                        horse: horse,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                child: const Text("Modifier"),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
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
