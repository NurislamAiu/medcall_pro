import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/color_screen.dart';
import '../../../../widgets/custom_text_filed.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: emailController,
          label: 'Почта',
          icon: Iconsax.sms,
          validator: _emailValidator,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: passwordController,
          label: 'Пароль',
          icon: Iconsax.lock,
          obscureText: true,
          validator: _passwordValidator,
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