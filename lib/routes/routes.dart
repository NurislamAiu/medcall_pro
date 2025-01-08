import 'package:flutter/material.dart';
import 'package:medcall_pro/screens/auth/forgot_password/forgot_password_screen.dart';
import '../screens/auth/login/login_screen.dart';
import '../screens/auth/register/register_screen.dart';
import '../screens/auth/waiting_screen.dart';
import '../screens/statistics/screens/all_bonus_screen.dart';
import '../widgets/navigation_bar.dart';


class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String waiting = '/waiting';
  static const String navBar = '/navbar';
  static const String bonus = '/bonus';
  static const String home = '/home';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> getRoutes(){
    return {
      login: (context) => LoginScreen(),
      register: (context) => RegisterScreen(),
      forgotPassword: (context) => ForgotPasswordScreen(),
      waiting: (context) => WaitingScreen(),
      navBar: (context) => NavBarScreen(),
      bonus: (context) => AllBonusesScreen(),
      // home: (context) => HomeScreen(),
      // profile: (context) => ProfileScreen(),
    };
  }
}