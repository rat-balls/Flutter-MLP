import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';
import 'package:flutter_mlp/class/user_profil/user_profil.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/widgets/edit_horse_form.dart';
import 'package:flutter_mlp/widgets/horse_card.dart';
import 'package:mongo_dart/mongo_dart.dart' as mango;

class HorseListWidget extends StatefulWidget {
  HorseListWidget({required this.userId, required this.horseList, super.key});

  late mango.ObjectId? userId;
  late List<Horse>? horseList;

  @override
  State<HorseListWidget> createState() => _HorseListWidget();
}

class _HorseListWidget extends State<HorseListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.horseList?.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              HorseCard(horse: widget.horseList![index]),
              Row(
                children: [
                  if (!widget.horseList![index].isUserIsOwner(widget.userId))
                    ElevatedButton(
                        onPressed: () {
                          User.associateUserWithHorse(
                              widget.horseList?[index].id, widget.userId);
                        },
                        child: const Text("Se déclarer proprio")),
                  if (!widget.horseList![index].isUserInDp(widget.userId) ||
                      !widget.horseList![index].isUserIsOwner(widget.userId))
                    ElevatedButton(
                        onPressed: () {
                          User.addUserToHorseDp(
                              widget.horseList?[index].id, widget.userId);
                        },
                        child: const Text("Se déclarer en dp")),
                  if (widget.horseList![index].isUserIsOwner(widget.userId))
                    ElevatedButton(
                        onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                      "Modifications des informations du cheval"),
                                  content: EditHorseForm(
                                      horse: widget.horseList![index]),
                                );
                              },
                            ),
                        child: const Text("Modifier le cheval"))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
