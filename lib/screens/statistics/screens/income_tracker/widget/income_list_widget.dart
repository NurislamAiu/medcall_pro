import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcall_pro/utils/color_screen.dart';
import '../daily_orders_screen.dart';
import '../data/income_data.dart';

class IncomeList extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String selectedPeriod;

  IncomeList({required this.data, required this.selectedPeriod});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final income = data[index];
        return GestureDetector(
          onTap: () {
            if (selectedPeriod == 'Неделя') {
              final orders = IncomeData.getOrdersForDay(income['day']);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DailyOrdersScreen(day: income['day'], orders: orders),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedPeriod == 'Сегодня' ? income['time'] : income['day'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${income['amount']} ₸',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ScreenColor.color6,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    income['details'],
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}