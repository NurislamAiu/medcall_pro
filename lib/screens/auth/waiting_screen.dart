import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medcall_pro/widgets/custom_banner.dart';


class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, String>? ?? {};
    final email = arguments['email'] ?? '';
    final password = arguments['password'] ?? '';

    Future<void> deleteCurrentUser(String email, String password) async {
      print("Удаление пользователя: $email");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomBannerOur(
            title: 'Спасибо за ожидание',
            subTitle: 'Мы работаем над обработкой вашей заявки. Это займет немного времени.',
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Lottie.asset(
                  'assets/lottie/waiting.json',
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}