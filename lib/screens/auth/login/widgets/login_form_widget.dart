import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medcall_pro/utils/validators.dart';
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
          controller: widget.emailController,
          label: 'Почта',
          icon: Iconsax.sms,
          validator: Validators.emailValidator
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: widget.passwordController,
          label: 'Пароль',
          icon: Iconsax.lock,
          obscureText: true,
          validator: Validators.passwordValidator
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