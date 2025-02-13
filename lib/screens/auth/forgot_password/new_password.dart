import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medcall_pro/utils/validators.dart';
import '../../../utils/color_screen.dart';
import '../../../utils/size_screen.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_filed.dart';

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {

      await Future.delayed(Duration(seconds: 2));

      Get.snackbar("Успех", "Пароль успешно изменен!",
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.back();
    } catch (error) {
      Get.snackbar("Ошибка", "Не удалось изменить пароль",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
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
                    'Новый пароль',
                    style: TextStyle(
                        color: ScreenColor.color2,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                  Text(
                    'Введите новый пароль для входа в систему.',
                    style: TextStyle(color: ScreenColor.color2, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    type: TextInputType.text,
                    label: 'Пароль',
                    icon: Iconsax.lock,
                    validator: Validators.passwordValidator,
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: confirmPasswordController,
                    type: TextInputType.text,
                    label: 'Повторите пароль',
                    icon: Iconsax.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите пароль еще раз";
                      } else if (value != passwordController.text) {
                        return "Пароли не совпадают";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: "Изменить пароль",
                    onPressed: _changePassword,
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