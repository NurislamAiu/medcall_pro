import 'package:flutter/material.dart';

import '../../../../utils/color_screen.dart';

class RequestDetailsCard extends StatelessWidget {
  final Map<String, dynamic> requestDetails;

  RequestDetailsCard({required this.requestDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Row
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(requestDetails['photoUrl']),
                backgroundColor: Colors.grey.shade300,
              ),
              SizedBox(width: 16),

              // User Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      requestDetails['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.green, size: 18),
                        SizedBox(width: 6),
                        Text(
                          requestDetails['phone'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Request Details
          _buildDetailItem(
            icon: Icons.assignment_outlined,
            title: 'Заявка',
            value: requestDetails['title'],
          ),
          _buildCustomDivider(),
          _buildDetailItem(
            icon: Icons.location_on_outlined,
            title: 'Адрес',
            value: requestDetails['address'],
          ),
          _buildCustomDivider(),
          _buildDetailItem(
            icon: Icons.watch_later_outlined,
            title: 'Время',
            value: requestDetails['time'],
          ),
          _buildCustomDivider(),
          _buildDetailItem(
            icon: Icons.attach_money,
            title: 'Стоимость',
            value: requestDetails['price'],
            valueColor: Colors.green,
          ),
          _buildCustomDivider(),
          _buildDetailItem(
            icon: Icons.info_outline,
            title: 'Дополнительно',
            value: requestDetails['additionalInfo'],
          ),
        ],
      ),
    );
  }

  /// Custom Divider
  Widget _buildCustomDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Divider(
        thickness: 1.5,
        color: Colors.grey.shade300,
      ),
    );
  }

  /// Detail Item
  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ScreenColor.color6.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: ScreenColor.color1),
        ),
        SizedBox(width: 12),

        // Title and Value
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: ScreenColor.color6,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}