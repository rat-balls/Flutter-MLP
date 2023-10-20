import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/event.dart';
import 'package:flutter_mlp/widgets/events_list.dart';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();

  late List<Event>? _events;
  late List<Event>? _valideEvents;

  bool _eventsDataLoaded = false;
}

class _AdminPageState extends State<AdminPage> {
  late List<Event>? _events;
  late List<Event>? _valideEvents;

  bool _eventsDataLoaded = false;

  Future<void> _getEvents() async {
    List<Event>? valideEventsList = await Event.getNotValidEvent();

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
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      await _getEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin'),
          titleTextStyle: const TextStyle(fontSize: 18),
          backgroundColor: const Color.fromARGB(255, 247, 184, 247),
        ),
        body: Container(
          color: const Color.fromARGB(255, 197, 224, 255),
          child: _eventsDataLoaded
              ? Stack(
                  children: <Widget>[
                    if (_eventsDataLoaded)
                      EventListWidget(eventList: _valideEvents),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 247, 184, 247),
          child: Center(
              child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const SizedBox(
                width: 150,
                height: 25,
                child: Center(
                    child: Text(
                  'Quitter',
                  style: TextStyle(color: Colors.white),
                ))),
          )),
        ));
  }
}
