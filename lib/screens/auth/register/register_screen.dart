import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medcall_pro/screens/auth/register/widgets/register_form_widget.dart';
import 'package:medcall_pro/screens/auth/register/widgets/register_head_widget.dart';

import '../../../utils/color_screen.dart';
import '../../../utils/size_screen.dart';
import '../../../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Контроллеры для полей ввода
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController iinController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController certificateController = TextEditingController();

  String _gender = 'Не выбран';

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Получаем данные из формы
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String fullName = nameController.text.trim();
      String iin = iinController.text.trim();
      String phone = phoneController.text.trim();
      String certificateNumber = certificateController.text.trim();
      String gender = _gender;
      int age = int.parse(ageController.text.trim());
      print('qwwe');

      // Регистрируем пользователя в Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      // Сохраняем данные пользователя в Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fullName': fullName,
        'email': email,
        'iin': iin,
        'age': age,
        'phone': phone,
        'certificateNumber': certificateNumber,
        'gender': gender,
        'createdAt': FieldValue.serverTimestamp(),
        'isApproved': false,
      });

      // Переход на главную страницу
      Navigator.pushReplacementNamed(context, '/waiting');
    } catch (e) {
      print("Ошибка регистрации: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenColor.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RegisterHead(),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: RegisterForm(
                          emailController: emailController,
                          passwordController: passwordController,
                          nameController: nameController,
                          iinController: iinController,
                          ageController: ageController,
                          phoneController: phoneController,
                          certificateController: certificateController,
                          gender: _gender,
                          onGenderChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 40),
                      CustomButton(
                        text: "Регистрация",
                        onPressed: _register,
                        colorBackground: ScreenColor.color6,
                      ),
                    ],
                  ),
                ),
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