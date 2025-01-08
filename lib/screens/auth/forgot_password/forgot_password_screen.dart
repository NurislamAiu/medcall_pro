import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
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
  late final TextEditingController emailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
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

  void _sendResetLink() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    Get.snackbar('Успешно!','Ссылка для сброса пароля отправлена на ${emailController.text}');

    Navigator.pop(context);
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
                  Column(
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
                        style:
                        TextStyle(color: ScreenColor.color2, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Почта',
                    icon: Iconsax.sms,
                    validator: _emailValidator,
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
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: CircularProgressIndicator(
                    color: ScreenColor.color6,
                  ),
                ),
              ),
            ),
          Positioned(
            top: ScreenSize(context).height * 0.1,
            right: 10,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}