import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/color_screen.dart';
import '../../../../widgets/custom_text_filed.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;
  late final TextEditingController iinController;
  late final TextEditingController certificateController;
  late final TextEditingController ageController;
  late final TextEditingController phoneController;

  String _gender = 'Не выбран';

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    iinController = TextEditingController();
    certificateController = TextEditingController();
    ageController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    iinController.dispose();
    certificateController.dispose();
    ageController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите адрес электронной почты';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Некорректный формат почты';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 6) {
      return 'Пароль должен быть не менее 6 символов';
    }
    return null;
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите имя';
    }
    return null;
  }

  String? _ageValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите возраст';
    }
    final age = int.tryParse(value);
    if (age == null || age <= 0) {
      return 'Возраст должен быть положительным числом';
    }
    return null;
  }

  String? _iinValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите ИИН';
    }

    // Удаление всех нецифровых символов
    final sanitizedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Проверка длины ИИН
    if (sanitizedValue.length != 12) {
      return 'ИИН должен содержать 12 цифр';
    }

    // Проверка корректности формата даты
    if (!_isValidDateParts(sanitizedValue)) {
      return 'Некорректная дата в ИИН';
    }

    // Проверка контрольной суммы
    if (!_isValidIINChecksum(sanitizedValue)) {
      return 'Некорректный ИИН';
    }

    return null;
  }

  bool _isValidDateParts(String iin) {
    final yearPart = int.parse(iin.substring(0, 2));
    final monthPart = int.parse(iin.substring(2, 4));
    final dayPart = int.parse(iin.substring(4, 6));

    // Проверка диапазона для года
    if (yearPart < 0 || yearPart > 99) {
      return false;
    }

    // Проверка диапазона для месяца
    if (monthPart < 1 || monthPart > 12) {
      return false;
    }

    // Проверка диапазона для дня
    if (dayPart < 1 || dayPart > 31) {
      return false;
    }

    return true;
  }

  bool _isValidIINChecksum(String iin) {
    const List<int> weights1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    const List<int> weights2 = [3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2];

    final digits = iin.split('').map(int.parse).toList();

    // Первая контрольная сумма
    final checksum1 = digits.asMap().entries.fold(0, (sum, entry) => sum + entry.value * weights1[entry.key]);

    if (checksum1 % 11 != 10) {
      return digits[11] == checksum1 % 11;
    }

    // Вторая контрольная сумма
    final checksum2 = digits.asMap().entries.fold(0, (sum, entry) => sum + entry.value * weights2[entry.key]);

    return digits[11] == checksum2 % 11;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите номер телефона';
    }

    // Удаляем все нечисловые символы
    final sanitizedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Проверяем только цифры
    if (sanitizedValue.length < 10 || sanitizedValue.length > 12) {
      return 'Некорректный номер телефона';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          label: 'Email',
          icon: Iconsax.sms,
          validator: _emailValidator,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: passwordController,
          obscureText: true,
          label: 'Пароль',
          icon: Iconsax.lock,
          validator: _passwordValidator,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: nameController,
          label: 'Ф.И.О',
          icon: Iconsax.user,
          validator: _nameValidator,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: certificateController,
          label: 'Номер Сертификата',
          icon: Iconsax.note,
          validator: _nameValidator,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: iinController,
                label: 'ИИН',
                icon: Iconsax.text_block,
                validator: _iinValidator,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: CustomTextField(
                controller: ageController,
                label: 'Возраст',
                icon: Iconsax.calendar,
                type: TextInputType.number,
                validator: _ageValidator,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: phoneController,
          label: 'Телефон',
          icon: Iconsax.mobile,
          type: TextInputType.phone,
          inputFormatters: [
            MaskedInputFormatter('+# (###) ###-##-##'),
          ],
          validator: _phoneValidator,
        ),
        SizedBox(height: 20),
        _buildGenderSelection(),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(Iconsax.aquarius,
                  color: ScreenColor.color1.withOpacity(0.5)),
              SizedBox(width: 10),
              Text('Пол',
                  style: TextStyle(color: ScreenColor.color2, fontSize: 16)),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: _gender,
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Colors.white,
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue!;
                  });
                },
                items: <String>['Не выбран', 'Мужчина', 'Женщина']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style:
                        TextStyle(color: ScreenColor.color2, fontSize: 14)),
                  );
                }).toList(),
                underline: SizedBox(),
                icon: Icon(Icons.arrow_drop_down, color: ScreenColor.color2),
              ),
            ],
          ),
        ),
        if (_gender == 'Не выбран')
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              'Выберите пол',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}