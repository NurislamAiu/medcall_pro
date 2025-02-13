import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcall_pro/screens/statistics/screens/income_tracker/widget/income_list_widget.dart';
import 'package:medcall_pro/screens/statistics/screens/income_tracker/widget/monthly_income_card_widget.dart';
import 'package:medcall_pro/screens/statistics/screens/income_tracker/widget/period_selector_widget.dart';
import 'package:medcall_pro/widgets/custom_banner.dart';

import 'data/income_data.dart';
class IncomeTrackerScreen extends StatefulWidget {
  @override
  _IncomeTrackerScreenState createState() => _IncomeTrackerScreenState();
}

class _IncomeTrackerScreenState extends State<IncomeTrackerScreen> {
  String selectedPeriod = 'Сегодня';

  @override
  Widget build(BuildContext context) {
    final data = IncomeData.getIncomeDataForPeriod(selectedPeriod);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBannerOur(title: 'Доходы', subTitle: 'Доходы subtitle'),
          SizedBox(height: 20),
          PeriodSelector(
            selectedPeriod: selectedPeriod,
            onPeriodChange: (period) {
              setState(() {
                selectedPeriod = period;
              });
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: selectedPeriod == 'Месяц'
                ? MonthlyIncomeCard()
                : IncomeList(data: data, selectedPeriod: selectedPeriod),
          ),
        ],
      ),
    );
  }
}