import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/event.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mlp/pages/admin_page.dart';

class EventCard extends StatefulWidget {
  final Event event;

  EventCard({required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  final AdminPage adminPage = AdminPage();
  late final Event _event;
  @override
  void initState() {
    _event = widget.event;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: 250,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _event.type,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    '${_event.date}',
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    child: IconButton(
                      iconSize: 40,
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          Event.acceptEvent(_event.id);
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      iconSize: 40,
                      color: Colors.red,
                      onPressed: () {
                        Event.deleteEvent(_event.id);
                      },
                      icon: Icon(Icons.remove),
                    ),
                  ),
                ],
              ),
            )

            /*  Text(
                'Présent: ${event.users!.isNotEmpty ? event.users?.join(', ') : 'Aucun'}'),
          ,*/
          ],
        ),
      ),
    );
  }
}
