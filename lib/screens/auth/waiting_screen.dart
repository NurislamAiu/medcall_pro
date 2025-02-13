import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medcall_pro/utils/color_screen.dart';
import 'package:medcall_pro/utils/size_screen.dart';
import 'package:medcall_pro/widgets/custom_banner.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> deleteCurrentUser(BuildContext context) async {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        User? user = auth.currentUser;

        if (user == null) {
          await Future.delayed(Duration(seconds: 2));
          user = auth.currentUser;
          if (user == null) {
            print("Пользователь не найден, возможно, уже удален.");
            return;
          }
        }

        String uid = user.uid;

        try {
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: 'UserTemporaryPassword123!',
          );
          await user.reauthenticateWithCredential(credential);
        } catch (e) {
          print("Не удалось повторно аутентифицировать: $e");
        }

        await FirebaseFirestore.instance.collection('users').doc(uid).delete();
        await user.delete();
        print("Аккаунт удален");

        await auth.signOut();

        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        print("Ошибка при удалении аккаунта: $e");
        Get.snackbar('Ошибка удаления аккаунта. ', 'Попробуйте снова.');
      }
    }

    void showBottomModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            height: ScreenSize(context).height * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Вы уверены, что хотите удалить аккаунт?",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Этот процесс необратим, и все данные будут потеряны.",
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      Lottie.asset("assets/lottie/canceled.json",
                          height: ScreenSize(context).height * 0.3)
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(20),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  ScreenColor.color2.withOpacity(0.2)),
                          child: Text(
                            "Отмена",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            deleteCurrentUser(context);
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(20),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white),
                          child: Text(
                            "Удалить аккаунт",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomBannerOur(
            title: 'Спасибо за ожидание',
            subTitle:
                'Мы работаем над обработкой вашей заявки. Это займет немного времени.',
            isButton: false,
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => showBottomModal(context),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor: ScreenColor.color2.withOpacity(0.2),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "Отменить регистрацию",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
