import 'package:get/get.dart';

class Validators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty)
      return 'Введите адрес электронной почты';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Некорректный формат почты';
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Введите пароль';
    if (value.length < 8) return 'Пароль должен быть не менее 8 символов';
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Введите имя';
    return null;
  }

  static String? ageValidator(String? value) {
    if (value == null || value.isEmpty) return 'Введите возраст';
    final age = int.tryParse(value);
    if (age == null || age <= 0)
      return 'Возраст должен быть положительным числом';
    if (age <= 18) return showError('Возраст должен быть больше 18 лет');
    if (age >= 50) return showError('Возраст должен быть меньше 50 лет');
    return null;
  }

  static String? iinValidator(String? value) {
    if (value == null || value.isEmpty) return 'Введите ИИН';

    final sanitizedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (sanitizedValue.length != 12) return 'ИИН должен содержать 12 цифр';

    if (!_isValidDateParts(sanitizedValue)) return 'Некорректная дата в ИИН';
    if (!_isValidIINChecksum(sanitizedValue)) return 'Некорректный ИИН';

    return null; // Если ошибок нет, возвращаем null (валидный ИИН)
  }

  static bool _isValidDateParts(String iin) {
    final int yearPart = int.parse(iin.substring(0, 2));
    final int monthPart = int.parse(iin.substring(2, 4));
    final int dayPart = int.parse(iin.substring(4, 6));

    if (yearPart < 0 || yearPart > 99) return false;
    if (monthPart < 1 || monthPart > 12) return false;
    if (dayPart < 1 || dayPart > 31) return false;

    return true;
  }

  static bool _isValidIINChecksum(String iin) {
    const List<int> weights1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    const List<int> weights2 = [3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2];

    final List<int> digits = iin.split('').map(int.parse).toList();

    // Проверяем, что у нас точно 12 цифр
    if (digits.length != 12) return false;

    // Вычисляем первую контрольную сумму
    final int checksum1 = List.generate(11, (i) => digits[i] * weights1[i]).reduce((a, b) => a + b) % 11;

    if (checksum1 != 10) {
      return digits[11] == checksum1;
    }

    // Вычисляем вторую контрольную сумму
    final int checksum2 = List.generate(11, (i) => digits[i] * weights2[i]).reduce((a, b) => a + b) % 11;

    return digits[11] == checksum2;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) return 'Введите номер телефона';

    // Удаляем все символы, кроме цифр
    final sanitizedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Должно быть 11 цифр (с учётом кода страны)
    if (sanitizedValue.length != 11) return 'Некорректный номер телефона';

    // Проверяем, начинается ли номер с 7 (Казахстан/Россия)
    if (!sanitizedValue.startsWith('7')) return 'Некорректный код страны';

    // Код оператора — 3 цифры после кода страны (второй, третий и четвёртый символ)
    final operatorCode = sanitizedValue.substring(1, 4);

    // Допустимые коды операторов Казахстана
    const validOperators = {
      '700',
      '701',
      '702',
      '703',
      '705',
      '706',
      '707',
      '708',
      '709',
      '747',
      '750',
      '751',
      '760',
      '761',
      '770',
      '771',
      '775',
      '776',
      '777',
      '778'
    };

    if (!validOperators.contains(operatorCode)) {
      return 'Недопустимый оператор';
    }

    return null;
  }

  static String? showError(String message) {
    Get.snackbar(
      'Ошибка',
      message,
      duration: const Duration(seconds: 3),
    );
    return message;
  }
}
