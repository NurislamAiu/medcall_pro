import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcall_pro/widgets/custom_banner.dart';

class DailyOrdersScreen extends StatelessWidget {
  final String day;
  final List<Map<String, dynamic>> orders;

  DailyOrdersScreen({required this.day, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: orders.isEmpty
          ? Center(
              child: Text(
                'Заказов нет',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            )
          : Column(
              children: [
                CustomBannerOur(title: 'Заказы за $day', subTitle: 'Sub title'),
                Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Время: ${order['time']}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Сумма: ₸ ${order['amount']}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Описание: ${order['details']}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
