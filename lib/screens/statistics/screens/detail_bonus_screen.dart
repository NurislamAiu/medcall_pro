import 'package:flutter/material.dart';
import 'package:medcall_pro/screens/statistics/screens/widgets/bonus_card_widget.dart';
import 'model/bonus_model.dart';

/// Детальный экран — показывает конкретный бонус
class DetailBonusScreen extends StatelessWidget {
  final BonusData bonus;

  const DetailBonusScreen({Key? key, required this.bonus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = bonus.title;
    final currentRequests = bonus.currentRequests;
    final targetRequests = bonus.targetRequests;
    final bonusAmount = bonus.bonusAmount;

    // Вычисляем прогресс
    final progress = currentRequests / (targetRequests == 0 ? 1 : targetRequests);
    final progressValue = (progress > 1) ? 1 : progress;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BonusCard(
          title: title,
          currentRequests: currentRequests,
          targetRequests: targetRequests,
          bonusAmount: bonusAmount,
          progressValue: progressValue.toDouble(),
        ),
      ),
    );
  }
}