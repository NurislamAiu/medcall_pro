import 'package:flutter/material.dart';
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

  void _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _isLoading = false;
    });

    Navigator.pushReplacementNamed(context, '/home');
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
                        child: RegisterForm(),
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