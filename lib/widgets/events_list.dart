import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/event.dart';
import 'package:flutter_mlp/widgets/Event_card.dart';
import 'package:mongo_dart/mongo_dart.dart' as mango;

class EventListWidget extends StatefulWidget {
  EventListWidget({required this.eventList, super.key});
  late List<Event>? eventList;

  @override
  State<EventListWidget> createState() => _EventListWidget();
}

class _EventListWidget extends State<EventListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.eventList?.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              EventCard(event: widget.eventList![index]),
            ],
          );
        },
      ),
    );
  }
}
