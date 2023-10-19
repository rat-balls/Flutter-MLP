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

  bool _eventsDataLoaded = false;

  Future<void> _getEvents() async {
    List<Event>? eventsList = await Events.getAllEvents();
    setState(() {
      _events = eventsList;
      _eventsDataLoaded = true;
    });
  }

  @override
  void initState(){
    super.initState();

    Future.delayed(const Duration(seconds: 10), () async{
      await _getEvents();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _eventsDataLoaded
          ? EventListWidget(eventList: _events)
          :const Center(),
    );
  }
}
