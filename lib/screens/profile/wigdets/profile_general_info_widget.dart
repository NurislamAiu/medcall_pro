import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/color_screen.dart';

class ProfileGeneralInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoBlock(Iconsax.clock, "8 Years", "Experience"),
          const Text('|', style: TextStyle(color: Colors.grey)),
          _buildInfoBlock(Iconsax.people, "3.5k +", "Patients"),
          const Text('|', style: TextStyle(color: Colors.grey)),
          _buildInfoBlock(Iconsax.star, "2.8k +", "Reviews"),
        ],
      ),
    );
  }

  Widget _buildInfoBlock(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, color: ScreenColor.color1, size: 24),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: ScreenColor.color6,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}