import 'package:flutter/material.dart';

/// Карточка с прогресс-баром и поздравлением
class BonusCard extends StatelessWidget {
  final String title;
  final int currentRequests;
  final int targetRequests;
  final double bonusAmount;
  final double progressValue;

  const BonusCard({
    Key? key,
    required this.title,
    required this.currentRequests,
    required this.targetRequests,
    required this.bonusAmount,
    required this.progressValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isGoalReached = currentRequests >= targetRequests;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Сделайте $targetRequests заявок на этой неделе, чтобы получить '
                  '$bonusAmount тг!\n(Ваш прогресс — $currentRequests заявок)',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('$currentRequests / $targetRequests'),
                const SizedBox(width: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progressValue,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade300,
                      color: progressValue >= 1
                          ? Colors.green
                          : Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isGoalReached)
              Column(
                children: [
                  const Icon(
                    Icons.celebration,
                    size: 40,
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Поздравляем! Вы получаете $bonusAmount тг!',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}