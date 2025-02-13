import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medcall_pro/screens/home/screens/widgets/request_details_card_widget.dart';
import 'package:medcall_pro/screens/home/screens/widgets/request_swipeable_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/color_screen.dart';
import '../../../utils/size_screen.dart';

class RequestDetailsScreen extends StatefulWidget {
  @override
  _RequestDetailsScreenState createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  final Map<String, dynamic> requestDetails = {
    'photoUrl': 'https://a.d-cd.net/b29f65cs-960.jpg',
    'name': 'Иван Иванов',
    'phone': '+7 777 123 45 67',
    'additionalInfo': 'Клиент просит проверить систему кондиционирования.',
    'title': 'Проверка системы',
    'address': 'г. Астана, ул. Абая, д. 15/1',
    'time': '12:00, 20 Января 2025',
    'price': '15,000 ₸',
  };

  String _buttonState = 'выезжаю'; // Начальное состояние кнопки

  /// Обработка завершения свайпа
  void _handleSwipeComplete() {
    setState(() {
      if (_buttonState == 'выезжаю') {
        _buttonState = 'на месте';
      } else if (_buttonState == 'на месте') {
        _buttonState = 'завершить';
      } else if (_buttonState == 'завершить') {
        print('Действие завершено');
        _buttonState = 'выезжаю'; // Сброс состояния для следующего действия
      }
    });
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
        children: [
          // Баннер вверху
          Container(
            width: double.infinity,
            height: ScreenSize(context).height * 0.30,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ScreenColor.color6,
                  ScreenColor.color6.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: ScreenColor.color6.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Заголовок и текст
                Text(
                  'Текущая заявка\nХорошего дня и продуктивной работы!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ScreenColor.white,
                  ),
                ),

                // Кнопка "Отменить заявку"
                ElevatedButton(
                  onPressed: () {
                    _cancelRequest();
                    // Логика отмены заявки
                    print('Заявка отменена');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ScreenColor.color1.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Отменить заявку',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Контент страницы с прокруткой
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Карточка с деталями заявки
                  RequestDetailsCard(requestDetails: requestDetails),
                  SizedBox(height: 24),

                  // Кнопки взаимодействия
                  _buildActionButtons(),

                  SizedBox(height: 24),

                  // Свайп-кнопка
                  SwipeableButton(
                    onSwipeComplete: _handleSwipeComplete,
                    buttonState: _buttonState,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Создание кнопок взаимодействия
  Widget _buildActionButtons() {
    return Row(
      children: [
        // Кнопка звонка
        Expanded(
          child: ElevatedButton(
            onPressed: () => _makePhoneCall(requestDetails['phone']),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.all(16), // Увеличено для круглой формы
              shape: CircleBorder(),
            ),
            child: Icon(
              Icons.phone,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        SizedBox(width: 12),

        // Кнопка карты
        Expanded(
          child: ElevatedButton(
            onPressed: () => _openMap(requestDetails['address']),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.all(16), // Увеличено для круглой формы
              shape: CircleBorder(),
            ),
            child: Icon(
              Icons.map,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        SizedBox(width: 12),

        // Кнопка экстренной службы
        Expanded(
          child: ElevatedButton(
            onPressed: _callEmergency,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.all(16), // Увеличено для круглой формы
              shape: CircleBorder(),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  /// Звонок клиенту
  void _makePhoneCall(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print('Не удалось сделать вызов.');
    }
  }

  /// Вызов экстренной службы
  void _callEmergency() async {
    final Uri emergencyUri = Uri(scheme: 'tel', path: '112');
    if (await canLaunchUrl(emergencyUri)) {
      await launchUrl(emergencyUri);
    } else {
      print('Не удалось вызвать экстренную службу.');
    }
  }

  void _openMap(String address) async {
    final String encodedAddress = Uri.encodeComponent(address);
    final Uri mapUri = Uri.parse('https://2gis.kz/search/$encodedAddress');

    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri);
    } else {
      print('Не удалось открыть 2GIS.');
    }
  }
}
