import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';



class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  // Initialize default values
  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  // Function to check if the date is between 1 and 30
  bool _isCustomNoteDate(DateTime day) {
    return day.day >= 1 && day.day <= 30;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Notes in Table Calendar'),
      ),
      body: Center(
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.now(),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarBuilders: CalendarBuilders(
            // Customizing the day cells using defaultBuilder
            defaultBuilder: (context, date, events) {
              // Check if the date is between 1 and 30 and show the note
              if (_isCustomNoteDate(date)) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.shade100,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '10km',
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ],
                  ),
                );
              }
              // Default day builder if no custom note
              return Center(child: Text('${date.day}'));
            },
          ),
        ),
      ),
    );
  }
}
