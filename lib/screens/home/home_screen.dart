import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medcall_pro/widgets/custom_banner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../utils/color_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkSavedState();
  }

  Future<void> _checkSavedState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUserId = prefs.getString('currentUserId');
    final savedRequestId = prefs.getString('currentRequestId');

    if (savedUserId != null && savedRequestId != null) {
      print('Saved state found: UserId: $savedUserId, RequestId: $savedRequestId');
    }
  }

  Future<void> _acceptRequest(BuildContext context, String userId,
      String requestId, Map<String, dynamic> request) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentUserId', userId);
      await prefs.setString('currentRequestId', requestId);

      print('Request accepted: UserId: $userId, RequestId: $requestId');
    } catch (e) {
      print('Error updating request status: $e');
    }
  }

  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  final DateFormat customDateFormat = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomBannerOur(title: 'Добро пожаловать', subTitle: 'Пожалуйста, выберите удобную для вас заявку', isButton: false,),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2100, 12, 31),
              calendarFormat: _calendarFormat,
              headerVisible: false,
              availableCalendarFormats: const {
                CalendarFormat.week: 'Week',
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: ScreenColor.color6,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Lottie.asset(
                'assets/lottie/job.json',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}