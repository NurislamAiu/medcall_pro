import 'package:flutter/material.dart';
import '../../../../utils/color_screen.dart';

class RegisterHead extends StatelessWidget {
  const RegisterHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Регистрация',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: ScreenColor.color2,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Введите данные для регистрации',
          style: TextStyle(
            fontSize: 16,
            color: ScreenColor.color2,
          ),
        ),
      ],
    );
  }
}