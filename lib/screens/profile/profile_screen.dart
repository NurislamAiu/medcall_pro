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
  Map<String, dynamic>? _cachedUserData;

  @override
  void initState() {
    super.initState();
    _getLocalUserData();
  }

  Future<void> _getLocalUserData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _cachedUserData = {
        'photoUrl': 'https://i.pinimg.com/originals/eb/e6/f4/ebe6f490ccff1daa0a3dc7d9dbbb92d3.png',
        'name': 'Ilyasov Nurislam',
        'specialist': 'Medicine DR.',
        'email': 'nurik@example.com',
        'address': 'Astana, Kazakhstan',
        'age': 20,
        'rating': 4.5,
        'gender': 'Male',
        'phone': '+7 777 123 45 67',
      };
      _isLoading = false;
    });
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
          ProfileBanner(data: _cachedUserData),
          ProfileGeneralInfo(),
          ProfileMoreInfo(data: _cachedUserData),
        ],
      ),
    );
  }
}