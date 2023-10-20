import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_mlp/widgets/controllerPage.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mlp/class/event.dart';
import 'package:table_calendar/table_calendar.dart';

import '../class/app_colors.dart';
import '../class/users/user.dart';

class TimelineCalendarPage extends StatefulWidget {
  const TimelineCalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  _TimelineCalendarPageState createState() => _TimelineCalendarPageState();
}

class _TimelineCalendarPageState extends State<TimelineCalendarPage> {
  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime.now();
  final _lastCalendarDate = DateTime(2050);
  Sort sortMethod = Sort.all;
  DateTime? selectedCalendarDate;

  late Map<DateTime, List<Event>>? _mySelectedEvents;
  late User? _userInfo;
  bool _coursLoaded = false;
  bool _userLoaded = false;

  Future<void> _getUserInfo() async {
    User? userInfo = await User.getUserInfo('alice@example.com');
    setState(() {
      _userInfo = userInfo;
      _userLoaded = true;
    });
  }

  Future<void> _getCoursInfo() async {
    Map<DateTime, List<Event>>? mySelectedEvents =
        await Event.getAllEventsTimed();
    setState(() {
      _mySelectedEvents = mySelectedEvents;
      _coursLoaded = true;
    });
  }

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      await _getCoursInfo();
      await _getUserInfo();
    });
  }

  List<Event> _listOfDayEvents(DateTime dateTime) {
    if (_coursLoaded) {
      DateTime? date =
          DateTime.parse(DateFormat('yyyy-MM-dd').format(dateTime));
      List<Event> eventsToReturn = [];

      if (sortMethod == Sort.all) {
        return _mySelectedEvents?[date] ?? [];
      } else if (sortMethod == Sort.cours) {
        _mySelectedEvents?[date]?.forEach((event) {
          if (event.type == 'Cours') {
            eventsToReturn.add(event);
          }
        });
      } else if (sortMethod == Sort.soiree) {
        _mySelectedEvents?[date]?.forEach((event) {
          if (event.type == 'Soiree') {
            eventsToReturn.add(event);
          }
        });
      } else if (sortMethod == Sort.concours) {
        _mySelectedEvents?[date]?.forEach((event) {
          if (event.type == 'Concours') {
            eventsToReturn.add(event);
          }
        });
      }
      return eventsToReturn;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                side: BorderSide(color: AppColors().bgColor, width: 2.0),
              ),
              child: _coursLoaded ? TableCalendar(
                focusedDay: _focusedCalendarDate,
                // today's date
                firstDay: _initialCalendarDate,
                // earliest possible date
                lastDay: _lastCalendarDate,
                // latest allowed date
                calendarFormat: CalendarFormat.month,
                // default view when displayed
                // default is Saturday & Sunday but can be set to any day.
                // instead of day number can be mentioned as well.
                weekendDays: const [DateTime.sunday, 6],
                // default is Sunday but can be changed according to locale
                startingDayOfWeek: StartingDayOfWeek.monday,
                // height between the day row and 1st date row, default is 16.0
                daysOfWeekHeight: 40.0,
                // height between the date rows, default is 52.0
                rowHeight: 60.0,
                // this property needs to be added if we want to show events
                eventLoader: _listOfDayEvents,
                onFormatChanged: (format) {
                  setState(() {
                    sortMethod = Sort.values[
                        sortMethod.index == Sort.values.length - 1
                            ? 0
                            : sortMethod.index + 1];
                  });
                },
                // Calendar Header Styling
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                      color: AppColors().unselectedItemColor, fontSize: 20.0),
                  decoration: BoxDecoration(
                      color: AppColors().bgColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  formatButtonTextStyle: TextStyle(
                      color: AppColors().unselectedItemColor, fontSize: 16.0),
                  formatButtonDecoration: BoxDecoration(
                    color: AppColors().selectedItemColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: AppColors().unselectedItemColor,
                    size: 28,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: AppColors().unselectedItemColor,
                    size: 28,
                  ),
                ),
                // Calendar Days Styling
                daysOfWeekStyle: DaysOfWeekStyle(
                  // Weekend days color (Sat,Sun)
                  weekendStyle: TextStyle(color: AppColors().selectedItemColor),
                ),
                // Calendar Dates styling
                calendarStyle: CalendarStyle(
                  // Weekend dates color (Sat & Sun Column)
                  weekendTextStyle:
                      TextStyle(color: AppColors().selectedItemColor),
                  // highlighted color for today
                  todayDecoration: const BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                  ),
                  // highlighted color for selected day
                  selectedDecoration: BoxDecoration(
                    color: AppColors().selectedItemColor,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) => events.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: events.length >= 4 ? 4 : events.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.only(top: 40),
                                padding: const EdgeInsets.all(1),
                                child: Container(
                                  // height: 10,
                                  width: 13,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (events[index] as Event).users !=
                                                  null &&
                                              _userLoaded
                                          ? (events[index] as Event)
                                                  .users!
                                                  .contains(_userInfo?.id)
                                              ? AppColors().selectedItemColor
                                              : AppColors().bgColor
                                          : AppColors().bgColor),
                                ));
                          })
                      : null,
                ),
                selectedDayPredicate: (currentSelectedDate) {
                  // as per the documentation 'selectedDayPredicate' needs to determine
                  // current selected day
                  return (isSameDay(
                      selectedCalendarDate!, currentSelectedDate));
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // as per the documentation
                  if (!isSameDay(selectedCalendarDate, selectedDay)) {
                    setState(() {
                      selectedCalendarDate = selectedDay;
                      _focusedCalendarDate = focusedDay;
                    });
                  }
                },
              ) : const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            ..._listOfDayEvents(selectedCalendarDate!).map(
              (event) => ListTile(
                leading: Icon(
                  Icons.done,
                  color: event.users != null && _userLoaded
                      ? event.users!.contains(_userInfo?.id)
                          ? AppColors().selectedItemColor
                          : AppColors().bgColor
                      : AppColors().bgColor,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text("Type:   ${event.type}"),
                ),
                subtitle: Text('Discipline:   ${event.discipline}'),
                trailing: Column(
                  children: [
                    Text(
                        'Heure: ${event.time != null ? DateFormat('kk:mm').format(event.time as DateTime) : 'Heure non planifiée'}'),
                    event.users != null && _userLoaded
                        ? Text(
                            'Participation: ${event.users!.contains(_userInfo?.id) ? 'Oui' : 'Non'}')
                        : const Text('')
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

enum Sort { all, cours, soiree, concours }
