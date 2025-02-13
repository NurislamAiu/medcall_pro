import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medcall_pro/utils/color_screen.dart';
import 'package:medcall_pro/utils/size_screen.dart';
import 'package:medcall_pro/widgets/custom_banner.dart';

class AwaitingResponseScreen extends StatefulWidget {
  final Map<String, dynamic> request;

  AwaitingResponseScreen({required this.request});

  @override
  _AwaitingResponseScreenState createState() => _AwaitingResponseScreenState();
}

class _AwaitingResponseScreenState extends State<AwaitingResponseScreen> {
  late Timer _timer;
  final ValueNotifier<int> _remainingTime =
  ValueNotifier(600); // 10 минут (600 секунд)

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _remainingTime.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value -= 1;
      } else {
        _timer.cancel();
        print("Время истекло!");
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$remainingSeconds";
  }

  void _cancelRequest() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Верхний индикатор для перетаскивания
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // Заголовок и текст
            Text(
              'Вы уверены?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Отмена заявки приведёт к её удалению. Это действие необратимо.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),

            Lottie.asset('assets/lottie/canceled.json'),

            // Кнопки действий
            Row(
              children: [
                // Кнопка "Нет"
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: ScreenColor.color1.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Нет',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 12),

                // Кнопка "Да"
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Закрыть диалог
                      Navigator.of(context).pop(); // Вернуться на предыдущий экран
                      print('Заявка отменена');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: ScreenColor.color6,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Да, отменить',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Banner with Title
          CustomBannerOur(
            title: 'Ожидание ответа',
            subTitle:
            'Мы уведомим вас, как только ваш запрос будет подтверждён.',
            isButton: false,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // Waiting Animation Section with Timer
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/lottie/waiting.json',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 12),
                          ValueListenableBuilder<int>(
                            valueListenable: _remainingTime,
                            builder: (context, remainingTime, child) {
                              return Column(
                                children: [
                                  Text(
                                    _formatTime(remainingTime),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: ScreenColor.color6,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'В течение этого времени не примет вашу заявку, вы можете отменить её.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 12),
                          // Cancel Button
                          ElevatedButton(
                            onPressed: _cancelRequest,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ScreenColor.color1.withOpacity(0.2),
                              padding:
                              const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Отменить заявку',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
              
                    SizedBox(height: 16),
              
                    // Combined User and Request Details
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // User Information
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                NetworkImage(widget.request['photoUrl']),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.request['name'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 16),
                                        SizedBox(width: 4),
                                        Text(
                                          '${widget.request['rating']}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${widget.request['price']}',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 16),
              
                          // Request Details
                          _buildCompactDetailItem(
                            icon: Icons.assignment_outlined,
                            title: 'Заявка',
                            value: widget.request['title'],
                          ),
                          Divider(endIndent: ScreenSize(context).width * 0.2),
                          _buildCompactDetailItem(
                            icon: Icons.location_on_outlined,
                            title: 'Адрес',
                            value: widget.request['address'],
                          ),
                          Divider(endIndent: ScreenSize(context).width * 0.2),
                          _buildCompactDetailItem(
                            icon: Icons.watch_later_outlined,
                            title: 'Время',
                            value: widget.request['time'],
                          ),
                        ],
                      ),
                    ),
              
                    SizedBox(height: 16),
              
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper for Compact Details
  Widget _buildCompactDetailItem({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 24, color: ScreenColor.color6),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            '$title: $value',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}