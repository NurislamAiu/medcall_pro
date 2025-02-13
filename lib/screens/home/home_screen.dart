import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:medcall_pro/screens/home/screens/await_request_screen.dart';
import 'package:medcall_pro/utils/size_screen.dart';
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
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  final DateFormat customDateFormat = DateFormat('dd.MM.yyyy');

  final List<Map<String, dynamic>> mockRequests = [
    {
      'title': 'Перевязка',
      'description': 'Необходима перевязка на дому.',
      'time': '12:30',
      'date': DateTime.now(),
      'name': 'Айгуль Т.',
      'photoUrl': 'https://a.d-cd.net/b29f65cs-960.jpg',
      'address': 'ул. Абая 45, Астана',
      'rating': 4.8,
      'price': '5000₸', // Добавлено поле
    },
    {
      'title': 'Инъекция',
      'description': 'Внутривенная инъекция.',
      'time': '14:00',
      'date': DateTime.now().add(Duration(days: 1)),
      'name': 'Бауыржан К.',
      'photoUrl': 'https://a.d-cd.net/4d4fc3u-960.jpg',
      'address': 'пр. Назарбаева 17, Алматы',
      'rating': 4.5,
      'price': '4000₸', // Добавлено поле
    },
    {
      'title': 'Капельница',
      'description': 'Проведение капельницы.',
      'time': '15:45',
      'date': DateTime.now(),
      'name': 'Жанар Б.',
      'photoUrl': 'https://a.d-cd.net/4d4fc3u-960.jpg',
      'address': 'ул. Сейфуллина 23, Караганда',
      'rating': 4.9,
      'price': '7000₸', // Добавлено поле
    },
    {
      'title': 'Консультация врача',
      'description': 'Требуется консультация специалиста.',
      'time': '17:00',
      'date': DateTime.now().add(Duration(days: 2)),
      'name': 'Марат С.',
      'photoUrl': 'https://via.placeholder.com/150',
      'address': 'ул. Кунаева 8, Шымкент',
      'rating': 4.6,
      'price': '10000₸', // Добавлено поле
    },
  ];

  Future<void> _acceptRequest(Map<String, dynamic> request) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AwaitingResponseScreen(request: request),
      ),
    );
  }

  Future<void> _rejectRequest(String title) async {
    // Логика для отклонения заявки
    print('Заявка отклонена: $title');
  }

  @override
  Widget build(BuildContext context) {
    // Фильтруем заявки по выбранной дате
    final filteredRequests = mockRequests
        .where((request) =>
            request['date'] != null &&
            customDateFormat.format(request['date']) ==
                customDateFormat.format(_selectedDate))
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          CustomBannerOur(
            title: 'Добро пожаловать',
            subTitle: 'Пожалуйста, выберите удобную для вас заявку',
            isButton: false,
          ),
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
            child: filteredRequests.isEmpty
                ? Center(
                    child: Lottie.asset(
                      'assets/lottie/job.json',
                      height: ScreenSize(context).height * 0.3,
                      fit: BoxFit.cover,
                    ),
                  )
                : ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    itemCount: filteredRequests.length,
                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.grey.shade100],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(2, 2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              /// Photo, Rating, Location, Time
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Photo
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.1),
                                    backgroundImage:
                                        NetworkImage(request['photoUrl']),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// Name
                                        Text(
                                          request['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),

                                        /// Rating
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.amber, size: 16),
                                            SizedBox(width: 4.0),
                                            Text(
                                              request['rating'].toString(),
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),

                                        /// Location
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                size: 16, color: ScreenColor.color6),
                                            SizedBox(width: 4.0),
                                            Expanded(
                                              child: Text(
                                                request['address'],
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        Row(
                                          children: [
                                            Icon(Icons.watch_later,
                                                size: 16, color: ScreenColor.color1.withOpacity(0.5)),
                                            SizedBox(width: 4.0),
                                            Text(
                                              'Время: ${request['time']}',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              Divider(color: Colors.grey[300], thickness: 1.0),

                              /// Request Title
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    request['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    request['price'],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),

                              /// Request Sub Title
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  request['description'],
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 16.0),

                              /// Request Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        _rejectRequest(request['title']);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Отклонить',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ScreenColor.color1.withOpacity(0.2),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 10.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        _acceptRequest(request);
                                      },
                                      icon: Icon(Icons.check,
                                          size: 18, color: Colors.white),
                                      label: Text('Принять',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 10.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
