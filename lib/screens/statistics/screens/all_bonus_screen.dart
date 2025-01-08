import 'package:flutter/material.dart';
import 'package:medcall_pro/widgets/custom_banner.dart';
import '../../../utils/color_screen.dart';
import 'detail_bonus_screen.dart';
import 'model/mock_bonus.dart';

/// Главный экран — показывает список всех «бонусов»
class AllBonusesScreen extends StatelessWidget {
  const AllBonusesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bonuses = mockBonuses;

    return Scaffold(
      body: Column(
        children: [
          CustomBannerOur(
            title: 'Ваши достижения',
            subTitle: 'Выполняйте заявки и зарабатывайте ещё больше бонусов!',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bonuses.length,
              itemBuilder: (context, index) {
                final bonus = bonuses[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [ScreenColor.background, Colors.white70],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(bonus.title),
                    subtitle: Text(
                      'Прогресс: ${bonus.currentRequests} / ${bonus.targetRequests}',
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBonusScreen(bonus: bonus),
                        ),
                      );
                    },
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
