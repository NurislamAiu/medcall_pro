import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medcall_pro/screens/auth/login/widgets/login_bottom_widget.dart';
import 'package:medcall_pro/screens/auth/login/widgets/login_form_widget.dart';
import 'package:medcall_pro/screens/auth/login/widgets/login_head_widget.dart';
import '../../../../widgets/custom_button.dart';
import '../../../utils/color_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/navbar');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Ошибка входа")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ScreenColor.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoginHead(),
                    SizedBox(height: 30),
                    LoginForm(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      text: 'Войти',
                      onPressed: _isLoading ? () {} : _login,
                      colorBackground: ScreenColor.color6,
                    ),
                    SizedBox(height: 20),
                    LoginBottom(),
                  ],
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
        ],
      ),
    );
  }
}