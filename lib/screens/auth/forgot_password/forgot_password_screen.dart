import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medcall_pro/utils/validators.dart';
import '../../../utils/color_screen.dart';
import '../../../utils/size_screen.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_filed.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() async {
    if (!_formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      Future.delayed(Duration(milliseconds: 100), () {
        Get.snackbar(
          'Успешно!',
          'Ссылка для сброса пароля отправлена',
          backgroundColor: Colors.green.withOpacity(0.7),
        );
      });
      Get.back();
    } catch (e) {
      Validators.showError('Не удалось отправить ссылку: ${e.toString()}');

    }

    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenColor.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Сброс пароля',
                    style: TextStyle(
                        color: ScreenColor.color2,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                  Text(
                    'Введите адрес электронной почты, чтобы получить ссылку для сброса пароля.',
                    style: TextStyle(color: ScreenColor.color2, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Почта',
                    icon: Iconsax.sms,
                    validator: Validators.emailValidator,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: "Отправить ссылку",
                    onPressed: _sendResetLink,
                    colorBackground: ScreenColor.color6,
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => isLoading.value
                ? Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ScreenColor.color6,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          Positioned(
            top: ScreenSize(context).height * 0.1,
            right: 10,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
