import 'package:flutter/material.dart';

import '../../../../utils/color_screen.dart';


class LoginHead extends StatelessWidget {
  const LoginHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Войдите в систему',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: ScreenColor.color2,
          ),
        ),
        Text(
          'Введите свои данные для входа',
          style:
          TextStyle(fontSize: 16, color: ScreenColor.color2),
        ),
      ],
    );
  }
}