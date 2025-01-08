import 'package:flutter/material.dart';

import '../../../../utils/color_screen.dart';

class LoginBottom extends StatefulWidget {
  const LoginBottom({
    super.key,
  });

  @override
  State<LoginBottom> createState() => _LoginBottomState();
}

class _LoginBottomState extends State<LoginBottom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.grey.withOpacity(0.1);
                }
                return null;
              }),
            ),
            child: Text(
              'Нет аккаунта? Зарегистрироваться',
              style: TextStyle(color: ScreenColor.color2),
            ),
          ),
        ),
      ],
    );
  }
}