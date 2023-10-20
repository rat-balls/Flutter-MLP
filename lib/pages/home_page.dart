import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/event.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/pages/admin_page.dart';
import 'package:flutter_mlp/widgets/events_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Event>? _events;
  late List<Event>? _valideEvents;

  late bool checkAdmin;
  late User? _userInfo;
  bool _userLoaded = false;

  Future<void> _getUserInfo() async {
    User? userInfo = User.currentUser;
    setState(() {
      _userInfo = userInfo;
      checkAdmin = userInfo!.isAdmin;
      _userLoaded = true;
    });
  }

  bool _eventsDataLoaded = false;

  Future<void> _getEvents() async {
    List<Event>? valideEventsList = await Event.getValideEvents();
    valideEventsList?.forEach((event) {
      if(event.date.isBefore(DateTime.now())) {
        Event.deleteEvent(event.id);
      }
    });
    valideEventsList = await Event.getValideEvents();
    valideEventsList?.sort((e1, e2) => e1.date.compareTo(e2.date));
    setState(() {
      _valideEvents = valideEventsList;
      _eventsDataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () async {
      await _getEvents();
      await _getUserInfo();
      print(checkAdmin);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 197, 224, 255),
        child: _eventsDataLoaded
            ? Stack(
                children: <Widget>[
                  if (_eventsDataLoaded)
                    EventListWidget(eventList: _valideEvents),
                  Positioned(
                    bottom:
                        20, // Ajustez la position du bouton comme vous le souhaitez
                    right: 20,
                    child: Visibility(
                      visible: _userLoaded ? checkAdmin : false,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AdminPage(),
                            ),
                          );
                        },
                        child: const Badge(
                          backgroundColor: Colors.pink,
                          label: Text('10'),
                          child: Icon(Icons.event_sharp),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

//