import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/color_screen.dart';
import '../../../../widgets/custom_text_filed.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: widget.emailController, // Используем переданный контроллер
          label: 'Почта',
          icon: Iconsax.sms,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Введите адрес электронной почты';
            }
            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
            if (!emailRegex.hasMatch(value)) {
              return 'Некорректный формат почты';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: widget.passwordController, // Используем переданный контроллер
          label: 'Пароль',
          icon: Iconsax.lock,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Введите пароль';
            }
            if (value.length < 6) {
              return 'Пароль должен быть не менее 6 символов';
            }
            return null;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgotPassword');
                },
                child: Text(
                  'Забыл пароль?',
                  style: TextStyle(
                    color: ScreenColor.color2.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}