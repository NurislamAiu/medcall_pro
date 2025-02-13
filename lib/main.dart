import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:medcall_pro/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  String initialRoute = await _getInitialRoute();
  FlutterNativeSplash.remove();

  runApp(MyApp(initialRoute: initialRoute));
}

Future<String> _getInitialRoute() async {

  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return '/login';
  }

  DocumentSnapshot userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get();

  if (userDoc.exists) {
    bool isApproved = userDoc['isApproved'] ?? false;
    return isApproved ? '/navbar' : '/waiting';
  } else {
    return '/login';
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: AppRoutes.getRoutes(),
    );
  }
}