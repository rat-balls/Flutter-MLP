import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_mlp/widgets/controllerPage.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mlp/class/event.dart';
import 'package:table_calendar/table_calendar.dart';

import '../class/app_colors.dart';

class TimelineCalendarPage extends StatefulWidget {
  const TimelineCalendarPage({Key? key, }) : super(key: key);

  @override
  _TimelineCalendarPageState createState() => _TimelineCalendarPageState();
}

class _TimelineCalendarPageState extends State<TimelineCalendarPage> {
  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime.now();
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;

  late Map<DateTime, List<Event>>? _mySelectedEvents;
  bool _coursLoaded = false;

  Future<void> _getCoursInfo() async {
    Map<DateTime, List<Event>>? mySelectedEvents = await Event.getAllEventsTimed();
    setState(() {
      _mySelectedEvents = mySelectedEvents;
      _coursLoaded = true;
    });
  }

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    super.initState();

    Future.delayed(const Duration(seconds: 10), () async {
      await _getCoursInfo();
    });
  }

  List<Event> _listOfDayEvents(DateTime dateTime) {
    if(!_coursLoaded) {
      return [];
    } else {
      DateTime? date = DateTime.parse(DateFormat('yyyy-MM-dd').format(dateTime));
      print(date);
      print(_mySelectedEvents?[date]);
      return _mySelectedEvents?[date] ?? [];
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
              child: TableCalendar(
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
                // Calendar Header Styling
                headerStyle: HeaderStyle(
                  titleTextStyle:
                  TextStyle(color: AppColors().unselectedItemColor, fontSize: 20.0),
                  decoration: BoxDecoration(
                      color: AppColors().bgColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  formatButtonTextStyle:
                    TextStyle(color: AppColors().unselectedItemColor, fontSize: 16.0),
                  formatButtonDecoration: BoxDecoration(
                    color: AppColors().bgColor,
                    borderRadius: BorderRadius.all(
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
                  weekendTextStyle: TextStyle(color: AppColors().selectedItemColor),
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
                  markerDecoration: BoxDecoration(
                      color: AppColors().selectedItemColor, shape: BoxShape.circle),
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
              ),
            ),
            ..._listOfDayEvents(selectedCalendarDate!).map(
                  (myEvents) => ListTile(
                leading: Icon(
                  Icons.done,
                  color: AppColors().selectedItemColor,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text("Type:   ${myEvents.type}"),
                ),
                subtitle: Text('Discipline:   ${myEvents.discipline}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
