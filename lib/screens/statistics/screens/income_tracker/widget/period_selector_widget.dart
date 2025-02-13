import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcall_pro/utils/color_screen.dart';

class PeriodSelector extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodChange;

  PeriodSelector({required this.selectedPeriod, required this.onPeriodChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ['Сегодня', 'Неделя', 'Месяц'].map((period) {
          return GestureDetector(
            onTap: () => onPeriodChange(period),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: selectedPeriod == period
                    ? ScreenColor.color6
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: selectedPeriod == period
                    ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
                    : [],
              ),
              child: Text(
                period,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                  selectedPeriod == period ? Colors.white : Colors.black87,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}