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

  void _login() async {
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

    Navigator.pushReplacementNamed(context, '/navBar');
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
                    LoginForm(),
                    SizedBox(height: 30),
                    CustomButton(
                      text: 'Войти',
                      onPressed: _login,
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