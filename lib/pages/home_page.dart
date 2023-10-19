import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/event.dart';
import 'package:flutter_mlp/widgets/events_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  late List<Event>? _events;
  late List<Event>? _valideEvents;

  bool _eventsDataLoaded = false;

  Future<void> _getEvents() async {
    List<Event>? valideEventsList = await Event.getValideEvents();

    /*List<Event>? eventsList = await Event.getAllEvents();
    await Event.acceptEvent(eventsList?[6].id);
    await Event.acceptEvent(eventsList?[7].id);
    await Event.deleteEvent(eventsList?[7].id);*/
    //Test pour accepter et supprimer les events
    setState(() {
      _valideEvents = valideEventsList;
      _eventsDataLoaded = true;
    });
  }

  @override
  void initState(){
    super.initState();

    Future.delayed(const Duration(seconds: 5), () async{
      await _getEvents();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _eventsDataLoaded
        ? EventListWidget(eventList: _valideEvents)
          : const Center(
              child: CircularProgressIndicator(),
          ),
    );
  }
}