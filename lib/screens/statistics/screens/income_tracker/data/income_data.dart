import 'package:intl/intl.dart';

class IncomeData {
  static final todayIncome = [
    {'time': '10:30', 'amount': 100, 'details': 'Консультация с клиентом'},
    {'time': '14:00', 'amount': 200, 'details': 'Услуга разработки дизайна'},
  ];

  static List<Map<String, dynamic>> getWeeklyIncome() {
    final now = DateTime.now();
    final dateFormat = DateFormat('dd');

    return List.generate(7, (index) {
      final date = now.subtract(Duration(days: index));
      return {
        'day': dateFormat.format(date),
        'amount': (7 - index) * 100,
        'details': '${7 - index} заказа выполнено',
        'orders': List.generate(7 - index, (orderIndex) => {
          'time': '${10 + orderIndex}:00',
          'amount': (orderIndex + 1) * 50,
          'details': 'Заказ №${orderIndex + 1}'
        })
      };
    }).reversed.toList();
  }

  static const monthlyTotalIncome = 3200;

  static List<Map<String, dynamic>> getIncomeDataForPeriod(String period) {
    switch (period) {
      case 'Сегодня':
        return todayIncome;
      case 'Неделя':
        return getWeeklyIncome();
      default:
        return [];
    }
  }

  static List<Map<String, dynamic>> getOrdersForDay(String day) {
    final weeklyIncome = getWeeklyIncome();

    // Извлечение объекта для указанного дня с корректным типом
    final result = weeklyIncome.firstWhere(
          (data) => data['day'] == day,
      orElse: () => <String, Object>{'orders': <Map<String, dynamic>>[]}, // Корректный тип для orElse
    );

    // Проверяем, есть ли ключ 'orders' и приводим его к List<Map<String, dynamic>>
    if (result.containsKey('orders') && result['orders'] is List) {
      return (result['orders'] as List).cast<Map<String, dynamic>>();
    }

    // Возвращаем пустой список, если данные не найдены
    return [];
  }
}