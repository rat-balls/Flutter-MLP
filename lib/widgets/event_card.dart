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
            Text('${event.date}'),
            /*  Text(
                'Présent: ${event.users!.isNotEmpty ? event.users?.join(', ') : 'Aucun'}'),
          ,*/
          ],
        ),
      ),
    );
  }
}
