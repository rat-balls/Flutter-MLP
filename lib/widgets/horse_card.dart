import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/horse.dart';

class HorseCard extends StatelessWidget {
  final Horse horse;

  HorseCard({required this.horse});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom: ${horse.name}'),
            Text('Âge: ${horse.age}'),
            Text('Robe: ${horse.coat}'),
            Text('Race: ${horse.breed}'),
            Text('Sexe: ${horse.gender}'),
            Text('Spécialités: ${horse.specialties.join(', ')}'),
            Text('Propriétaire: ${horse.owner ?? 'Non spécifié'}'),
            Text(
                'DP: ${horse.dp!.isNotEmpty ? horse.dp?.join(', ') : 'Aucun'}'),
          ],
        ),
      ),
    );
  }
}
