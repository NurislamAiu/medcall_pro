import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/color_screen.dart';
import '../../utils/size_screen.dart';

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
        'photoUrl': null,
        'name': 'Ilyasov Nurislam',
        'email': 'nurik@example.com',
        'address': 'Astana, Kazakhstan',
        'age': 20,
        'gender': 'Female',
        'phone': '+7 777 123 45 67',
      };
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: ScreenColor.color6))
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : Column(
        children: [
          Container(
            width: double.infinity,
            height: ScreenSize(context).height * 0.30,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ScreenColor.color6,
                  ScreenColor.color6.withOpacity(0.2)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: ScreenColor.color6.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _cachedUserData!['photoUrl'] !=
                          null
                          ? NetworkImage(_cachedUserData!['photoUrl'])
                          : null,
                      child: _cachedUserData!['photoUrl'] == null
                          ? const Icon(Icons.person,
                          size: 50, color: ScreenColor.color6)
                          : null,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        icon: const Icon(Iconsax.setting,
                            color: Colors.white))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _cachedUserData!['name'] ?? "Unknown User",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      _cachedUserData!['email'] ?? "Unknown User",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                _buildInfoCard(
                    icon: Iconsax.location,
                    title: "Адрес",
                    value: _cachedUserData!['address'] ??
                        "Not Available"),
                _buildInfoCard(
                    icon: Iconsax.calendar_1,
                    title: "Возраст",
                    value: _cachedUserData!['age']?.toString() ??
                        "Not Available"),
                _buildInfoCard(
                    icon: Iconsax.user,
                    title: "Пол",
                    value: _cachedUserData!['gender'] ??
                        "Not Available"),
                _buildInfoCard(
                    icon: Iconsax.call,
                    title: "Телефон",
                    value:
                    _cachedUserData!['phone'] ?? "Not Available"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      {required IconData icon, required String title, required String value}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [ScreenColor.background, Colors.white70],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: ScreenColor.color6),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: TextStyle(color: Colors.grey[700])),
      ),
    );
  }
}
