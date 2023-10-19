import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.type),
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
