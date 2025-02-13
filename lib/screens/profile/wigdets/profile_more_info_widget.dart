import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/color_screen.dart';

class ProfileMoreInfo extends StatelessWidget {
  final Map<String, dynamic>? data;

  const ProfileMoreInfo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoCard(
              icon: Iconsax.location,
              title: "Address",
              value: data?['address'] ?? "Not Available",
            ),
            buildInfoCard(
              icon: Iconsax.calendar,
              title: "Age",
              value: data?['age']?.toString() ?? "Not Available",
            ),
            buildInfoCard(
              icon: Iconsax.man,
              title: "Gender",
              value: data?['gender']?.toString() ?? "Not Available",
            ),
            buildInfoCard(
              icon: Iconsax.mobile,
              title: "Phone",
              value: data?['phone']?.toString() ?? "Not Available",
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildInfoCard({
  required IconData icon,
  required String title,
  required String value,
}) {
  return ListTile(
    leading: Icon(icon, color: ScreenColor.color1),
    title: Text(title,
        style: TextStyle(fontWeight: FontWeight.bold, color: ScreenColor.color6)),
    subtitle: Text(value, style: TextStyle(color: Colors.grey[700])),
  );
}