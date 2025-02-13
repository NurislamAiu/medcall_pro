import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medcall_pro/screens/profile/wigdets/profile_banner_widget.dart';
import 'package:medcall_pro/screens/profile/wigdets/profile_general_info_widget.dart';
import 'package:medcall_pro/screens/profile/wigdets/profile_more_info_widget.dart';

import '../../utils/color_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  String _errorMessage = '';
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
      if (uid.isEmpty) {
        throw Exception("User not logged in");
      }

      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        throw Exception("User data not found");
      }

      setState(() {
        _userData = userDoc.data() as Map<String, dynamic>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ошибка загрузки данных: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка выхода: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: ScreenColor.color6))
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : Column(
        children: [
          ProfileBanner(data: _userData),
          ProfileGeneralInfo(data: _userData),
          ProfileMoreInfo(data: _userData),
          ElevatedButton(onPressed: _logout, child: Text('Exit'))
        ],
      ),
    );
  }
}